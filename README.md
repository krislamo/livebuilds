# livebuilds

livebuilds is a simple Makefile using GNU Stow packages to manage configuration
for building custom Debian live ISO images in a minimal and reproducible
workflow.

## Quick Start

The Makefile automates initialization, configuration, build, and optional test
run of the generated image. Typical usage:

1.  Build the image

        make

    Initializes the build directory, configures it using `stow` packages, and
    runs `live-build` to produce the ISO in `./builds/$DIST/`.

2.  Boot the image in a VM (QEMU/KVM via libvirt)

        make install

    Launches a `virt-install` user session, attaching the newly created ISO.

3.  Clean up everything

        make clean

    Destroys and undefines the VM (`live_trixie` by default) and removes the
    entire `./builds` directory.

## Copyright and License

Copyright (C) 2025 Kris Lamoureux

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/>.
