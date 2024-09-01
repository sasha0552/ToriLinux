# ToriLinux maintenance (developer documentation)

## Working with projects

### Update project versions

You can use `.ci/update.py` to update project versions.

### Add/modify/delete a project

You can add/remove/modify the script(s) in `airootfs/root/customize_airootfs/scripts`.

For now, you can use other scripts for reference.

Use `.ci/configure.py [cuda|rocm] [gui|normal]` to render these templates.

## Working with CI

Modify any of the templates in `.ci/templates/` or `.ci/actions.py`.

Use `.ci/actions.py` to regenerate CI workflows in `.github/actions/`.

## Build locally

You need ArchLinux or at least any linux distribution that supports Docker (you can use a Docker image of ArchLinux).

Install the dependencies listed in the `.ci/dependencies.sh` file.

Render the scripts using `.ci/configure.py [cuda|rocm] [gui|normal]`.

Optionally, you can run `.ci/empty.sh` after `.ci/configure.py` to create an empty image.

Run `mkarchiso -v -m iso -w /some/temporary/directory -o /some/output/directory .` to build the image.

Preferably use tmpfs (e.g., `/tmp/mkarchiso`) for the temporary directory (note that you need more than 50 GB of free space in that directory).
