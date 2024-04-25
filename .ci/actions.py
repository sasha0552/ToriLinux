#!/usr/bin/env python3

import jinja2

def render_template(input_path, output_path, **options):
  # read input file
  with open(input_path, "r") as file:
    template = jinja2.Template(file.read(), lstrip_blocks=True, trim_blocks=True)

  # render template
  rendered = template.render(**options)

  # write output file
  with open(output_path, "w") as file:
    file.write(rendered)

def main():
  # define directories
  i = ".ci/template"
  o = ".github/workflows"

  # render templates
  render_template(f"{i}/gh-build-iso.yml.jinja2", f"{o}/gh-build-iso-cuda.yml"      , platform="cuda", type="normal")
  render_template(f"{i}/gh-build-iso.yml.jinja2", f"{o}/gh-build-iso-cuda-empty.yml", platform="cuda", type="empty")
  render_template(f"{i}/gh-build-iso.yml.jinja2", f"{o}/gh-build-iso-cuda-gui.yml"  , platform="cuda", type="gui")
  render_template(f"{i}/gh-build-iso.yml.jinja2", f"{o}/gh-build-iso-rocm.yml"      , platform="rocm", type="normal", delay=0)
  render_template(f"{i}/gh-build-iso.yml.jinja2", f"{o}/gh-build-iso-rocm-empty.yml", platform="rocm", type="empty")
  render_template(f"{i}/gh-build-iso.yml.jinja2", f"{o}/gh-build-iso-rocm-gui.yml"  , platform="rocm", type="gui", delay=30)

if __name__ == "__main__":
  main()
