#!/usr/bin/env python3

import configparser
import requests

def fetch_latest_revision(url):
  # github
  if url.startswith("https://github.com/") and url.endswith(".git"):
    # extract repo path
    path = url[19:-4]

    # get commits from api
    response = requests.get(f"https://api.github.com/repos/{path}/commits")

    # throw error if not success
    response.raise_for_status()

    # parse json
    data = response.json()

    # return first commit id
    return data[0]["sha"]

  raise ValueError(f"Unsupported: {url}")

def main():
  # load options
  config = configparser.ConfigParser()
  config.read(".ci/options.ini")

  # default option value
  config["revisions"] = {}

  # iterate over repositories
  for key, value in config.items("repositories"):
    config["revisions"][key] = fetch_latest_revision(value)

  # write config back
  with open(".ci/options.ini", "w") as file:
    config.write(file)

if __name__ == "__main__":
  main()
