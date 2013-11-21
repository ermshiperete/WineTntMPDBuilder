WineTntMPDBuilder
=================

This script allows to build a wine version that is known to be able to
run TntMPD and install TntMPD. The custom wine version together with
TntMPD will be created in $HOME/wineTntMPD. This has the advantage that
it isn't affected by upgrades of the system wine package.

Wine itself as well as the installed TntMPD are stored in a git repo so
that it is easy to go back to a known running-state if an update of
TntMPD should go wrong. If you want to save space you can safely delete
the $HOME/wineTntMPD/.git subdirectory.

The current script builds and installs wine 1.7.6 and TntMPD 3.0.21.

Installation
------------

Wine only builds on 32-bit systems. The easiest way to get it working
is probably to install a 32-bit virtual machine.

You need at least 2GB of free disk space to build and install wine and
TntMPD.

Copy the build.sh to a directory and run it. This will clone and build the
wine source code, install wine into $HOME/wineTntMPD and then download and
install TntMPD. During the installation of TntMPD the setup program will
download and install some additional required components.
