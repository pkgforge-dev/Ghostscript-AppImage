#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q ghostscript | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/ArtifexSoftware/ghostpdl/blob/master/doc/src/images/ghostscript-logo.png
export DESKTOP=DUMMY

# Deploy dependencies
quick-sharun \
	/usr/bin/dvipdf       \
	/usr/bin/eps2eps      \
	/usr/bin/ghostscript  \
	/usr/bin/gs           \
	/usr/bin/gsbj         \
	/usr/bin/gsdj         \
	/usr/bin/gsdj500      \
	/usr/bin/gslj         \
	/usr/bin/gslp         \
	/usr/bin/gsnd         \
	/usr/bin/gsx          \
	/usr/bin/pdf2dsc      \
	/usr/bin/pdf2ps       \
	/usr/bin/pf2afm       \
	/usr/bin/pfbtopfa     \
	/usr/bin/pphs         \
	/usr/bin/printafm     \
	/usr/bin/ps2ascii     \
	/usr/bin/ps2epsi      \
	/usr/bin/ps2pdf       \
	/usr/bin/ps2pdf12     \
	/usr/bin/ps2pdf13     \
	/usr/bin/ps2pdf14     \
	/usr/bin/ps2pdfwr     \
	/usr/bin/ps2ps        \
	/usr/bin/ps2ps2

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
