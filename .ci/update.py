#!/usr/bin/env python3

import configparser
import requests

def fetch_latest_revision(url, strategy):
  # github
  if url.startswith("https://github.com/") and url.endswith(".git"):
    # extract repo path
    path = url[19:-4]

    match strategy:
      case "commit":
        # get commits from api
        response = requests.get(f"https://api.github.com/repos/{path}/commits")

        # throw error if not success
        response.raise_for_status()

        # parse json
        data = response.json()

        # return first commit id
        return data[0]["sha"]

      case "release":
        # get releases from api
        response = requests.get(f"https://api.github.com/repos/{path}/releases")

        # throw error if not success
        response.raise_for_status()

        # parse json
        data = response.json()

        # find first release
        for release in data:
          if not release["prerelease"]:
            return release["tag_name"]

  raise ValueError(f"Unsupported url or strategy ({url}, {strategy})")

def main():
  # load options
  config = configparser.ConfigParser()
  config.read(".ci/options.ini")

  # default option value
  if "revisions" not in config:
    config["revisions"] = {}

  # default option value
  if "strategy" not in config:
    config["strategy"] = {}

  # iterate over repositories
  for key, value in config.items("repositories"):
    # update strategy
    strategy = "commit"

    # extract strategy
    if key in config["strategy"]:
      strategy = config["strategy"][key]

    # if not locked, update
    if strategy != "locked":
      config["revisions"][key] = fetch_latest_revision(value, strategy)

  # write config back
  with open(".ci/options.ini", "w") as file:
    config.write(file)

if __name__ == "__main__":
  main()
