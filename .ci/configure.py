#!/usr/bin/env python3

import configparser
import glob
import jinja2
import json
import sys

def render_template(filepath, **options):
  if filepath.endswith(".jinja2"):
    # read input file
    with open(filepath, "r") as file:
      template = jinja2.Template(file.read(), lstrip_blocks=True, trim_blocks=True)

    # render template
    rendered = template.render(**options)

    # write output file
    with open(filepath[:-7], "w") as file:
      file.write(rendered)

def main():
  # by default, use cuda
  platform = "cuda"

  # and normal iso
  type = "normal"

  # and empty options
  options = {}

  # set platform
  if len(sys.argv) >= 2:
    platform = sys.argv[1]

  # set type
  if len(sys.argv) >= 3:
    type = sys.argv[2]

  # load options
  config = configparser.ConfigParser()
  config.read(".ci/options.ini")

  # repositories
  options["repositories"] = dict(config.items("repositories"))

  # revisions
  options["revisions"] = dict(config.items("revisions"))

  # files
  options["files"] = dict(config.items("files"))

  def gh_release(name, index = None):
    fn = options["files"][name]
    if index is not None:
      fn = json.loads(fn)[index]
    return f"{options['repositories'][name]}/releases/download/{options['revisions'][name]}/{fn}"

  # list of rendered files
  rendered = []

  # render every file
  for filepath in glob.glob("**/*.jinja2", recursive=True) + [".gitignore.jinja2"]:
    # sort rendered list
    rendered.sort()

    # render file
    render_template(filepath, platform=platform, type=type, rendered=rendered, gh_release=gh_release, **options)

    # add output file to rendered list
    rendered.append(filepath[:-7].replace("\\", "/"))

    # print status
    print(f"File '{filepath}' rendered successfully")

if __name__ == "__main__":
  main()
