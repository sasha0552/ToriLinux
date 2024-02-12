#!/usr/bin/env python3

import jinja2

def main():
  for filename in [ "gh-build-iso" ]:
    for type in [ "cuda", "rocm" ]:
      # read input file
      with open(f".ci/{filename}.yml.jinja2", "r") as file:
        template = jinja2.Template(file.read())

      # render template
      rendered = template.render(type=type)

      # FIXME: skip if hosted and rocm
      if filename == "gh-build-iso" and type == "rocm":
        continue

      # write output file
      with open(f".github/workflows/{filename}-{type}.yml", "w") as file:
        file.write(rendered)

if __name__ == "__main__":
  main()
