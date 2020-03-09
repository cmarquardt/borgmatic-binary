[![Build Status](https://travis-ci.com/cmarquardt/borgmatic-binary.svg?branch=master)](https://travis-ci.com/cmarquardt/borgmatic-binary)

# borgmatic-binary

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

Binary versions for 64-bit Linux systems can be downloaded from the [releases
page](https://github.com/cmarquardt/borgmatic-binary/releases); they track
the official `borgmatic` releases. For other or non-Linux platforms, binaries
can be build manually (see below), but require a working Python 3 installation.

## Installation

Unpack the `borgmatic-<version>-<architecture>.tar.gz` archive and move the
four borgmatic executables (`borgmatic`, `generate-borgmatic-config`,
`upgrade-borgmatic-config` and `validate-borgmatic-config`) from the
subdirectory `bin` to a convenient location somewhere in your `PATH`, e.g.:

    tar -xvf borgmatic-<version>-<architecture>.tar.gz
    sudo cp borgmatic-<version>-<architecture>/bin/* /usr/local/bin

 When installing in a system directory, e.g. into `/usr/local/bin` (as in the
 example above), root permissions or using the `sudo` command will be necessary.

## Building manually

Borgmatic requires Python 3; therefore the build will fail if the default python
has an older (2.x) version. The ideal setup is to work in a vanilla virtualenv
for python3, in which pyinstaller is installed with:

    pip install pyinstaller

The build process will install `borgmatic` into the current python environment.
PyInstaller can make use [UPX](https://upx.github.io/) if it is installed;
otherwise, the binaries will still be build, but require more space.

Note: With recent a recent version of `pip`, there seems to be a problem when 
trying to install packages into a virtual environment with `--system-site-packages`
enabled; it results in an error message stating that

> `AttributeError: module 'setuptools.build_meta' has no attribute '__legacy__'`

A workaround is to use

    pip install --no-use-pep517 pyinstaller

for the time being. See [this](https://github.com/pypa/pip/issues/6264) and 
[this](https://github.com/pypa/setuptools/issues/1694) issue for `pip` and 
`setuptools`, respectively.

After cloning the repository, the following make targets can be used:

    make            # Builds binaries for the current system file
    make dist       # Creates the distribution .tar.gz file
    make clean      # Cleans up binaries
    make realclean  # Cleans up binaries and the downloaded borgmatic source code
    make distclean  # Cleans up binaries, downloaded borgmatic sources and the distribution .tar.gz file

After a `make`, the binaries build are available in the directory
`borgmatic-<version>/dist`; they will be removed by `make clean`.

## Reporting issues

If you find issues, please open a ticket on the [issue tracker](https://github.com/cmarquardt/borgmatic-binary/issues/).
