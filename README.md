[![Build Status](https://travis-ci.com/cmarquardt/borgmatic-binary.svg?branch=master)](https://travis-ci.com/cmarquardt/borgmatic-binary)

## borgmatic-binary

## Overview

[Borgmatic](https://torsion.org/borgmatic/) is a simple Python wrapper script for the
[Borg](https://www.borgbackup.org/) backup software that initiates a backup,
prunes any old backups according to a retention policy, and validates backups
for consistency. The script supports specifying your settings in a declarative
configuration file rather than having to put them all on the command-line, and
handles common errors.

`borgmatic-binary` builds a binary distribution of the three borgmatic binaries
using [PyInstaller](https://www.pyinstaller.org/); its purpose is to provide a
simple binary installation option not requiring a full Python installation. It
is similar to the stand-alone `borg` binary availble from the `borg` download page.

## Releases

Binary versions for 64-bit Linux systems can be downloaded from XXX; they track
the official `borgmatic` releases. For other or non-Linux platforms, binaries
can be build manually (see below), but require a working Python 3 installation.

## Installation

Unpack the `borgmatic-<version>-<architecture>.tar.gz` archive and move the
three borgmatic executables (`borgmatic`, `generate-borgmatic-config` and
`upgrade-borgmatic-config`) from the subdirectory `bin` to a convenient location
somewhere in your PATH. When installing in a system directory, e.g. into
`/usr/local/bin`, root permissions or using the `sudo` command will be necessary.

## Building manually

Borgmatic requires Python 3; therefore the build will fail if the default python
has an older (2.x) version. Ideally work in a vanilla virtualenv for python3.

The build process will install both `pyinstaller` and `borgmatic` into the
current python environment.

Clone the repository, and then from the top directory:

    make            # Builds binaries for the current system file
    make dist       # Creates the distribution .tar.gz file
    make clean      # Cleans up binaries
    make realclean  # Cleans up binaries and the downloaded borgmatic source code
    make distclean  # Cleans up binaries, downloaded borgmatic sources and the distribution .tar.gz file

After the build, the three binaries can also be found in the directors
`borgmatic-<version>/dist`; they will however be removed by `make clean`.
