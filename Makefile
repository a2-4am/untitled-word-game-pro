#
# Untitled Word Game Pro makefile
# assembles source code, optionally builds a disk image and mounts it
#
# original by Quinn Dunki on 2014-08-15
# One Girl, One Laptop Productions
# http://www.quinndunki.com/blondihacks
#
# adapted by 4am on 2022-04-16
#

# third-party tools required to build

# https://sourceforge.net/projects/acme-crossass/
ACME=acme

# https://github.com/mach-kernel/cadius
# version 1.4.4 or later
CADIUS=cadius

BUILDDISK=build/Untitled Word Game Pro

asm: md
	$(ACME) -r build/untitled.lst src/untitled.a 2>build/log
	$(ACME) -r build/proboot.lst src/proboot.a 2>>build/log

dist: asm
	cp "res/_FileInformation.txt" "build/_FileInformation.txt"
	cadius CREATEVOLUME "$(BUILDDISK).po" UNTITLED 140kb >>build/log
	$(CADIUS) ADDFILE "$(BUILDDISK).po" "/UNTITLED/" "build/UNTITLED.SYSTEM" >>build/log
	bin/changebootloader.sh "$(BUILDDISK).po" build/proboot 2>>build/log
	bin/po2do.py build/ build/
	rm "$(BUILDDISK).po"

clean:
	rm -rf build/

md:
	mkdir -p build
	touch build/log

mount: dist
	open "$(BUILDDISK)".dsk

all: clean mount

al: all
