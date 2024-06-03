#!/usr/bin/env python3

import configparser
import json
import requests

def fetch_latest_revision(url, strategy):
  # parse strategy
  strategy = strategy.split("+", 2)
  release_strategy = strategy[0]
  file_strategy = strategy[1] if len(strategy) == 2 else None

  # github
  if url.startswith("https://github.com/"):
    # extract repo path
    path = url[19:]

    match release_strategy:
      case "commit":
        # get commits from api
        response = requests.get(f"https://api.github.com/repos/{path}/commits")

        # throw error if not success
        response.raise_for_status()

        # parse json
        data = response.json()

        # return first commit id and no file
        return data[0]["sha"], None

      case "release":
        # get releases from api
        response = requests.get(f"https://api.github.com/repos/{path}/releases")

        # throw error if not success
        response.raise_for_status()

        # parse json
        data = response.json()

        # first release
        _release = None

        # return variables
        ret_release = None
        ret_file = None

        # find first release
        for release in data:
          if not release["prerelease"]:
            _release = release
            ret_release = release["tag_name"]
            break

        match file_strategy:
          case "first":
            # return first file
            ret_file = release["assets"][0]["name"]

          case "sorted":
            # return all files as sorted json
            ret_file = json.dumps(sorted([asset["name"] for asset in release["assets"]]))

        # return release and file
        return ret_release, ret_file

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

    # if needed, update version
    if not strategy.startswith("branch") and not strategy.startswith("locked"):
      # fetch info
      revision, file = fetch_latest_revision(value, strategy)

      # update revision
      config["revisions"][key] = revision

      # if needed, update file
      if file is not None:
        config["files"][key] = file

  # write config back
  with open(".ci/options.ini", "w") as file:
    config.write(file)

if __name__ == "__main__":
  main()
