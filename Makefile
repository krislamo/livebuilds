.PHONY: default init configure build install clean

DIST := trixie
INFO := debian13
NAME := live_$(DIST)
SESH := qemu:///session
PKGS := base sway
STOW := base
MACH := q35
VCPU := 2
MEM  := 8192
NET  := user,model=virtio
CPU  := host-passthrough
ISO  := $(shell readlink -f ./builds/$(DIST)/live-image-amd64.hybrid.iso)

default: init configure build

init:
	mkdir -p builds/$(DIST)
	cd builds/$(DIST) && \
	lb config --distribution $(DIST) --debian-installer live

configure:
	stow -v -t ./builds/$(DIST) -D $(PKGS)
	stow -v -t ./builds/$(DIST) $(STOW)

build:
	cd builds/$(DIST) && \
	sudo lb clean --chroot && \
	sudo lb build

install:
	virt-install \
		--connect "$(SESH)" \
		--name "$(NAME)" \
		--osinfo "$(INFO)" \
		--vcpus "$(VCPU)" \
		--memory "$(MEM)" \
		--machine "$(MACH)" \
		--cpu "$(CPU)" \
		--virt-type kvm \
		--cdrom "$(ISO)" \
		--disk none \
		--network "$(NET)" \
		--graphics spice,listen=127.0.0.1,image.compression=off \
		--video virtio \
		--noautoconsole

clean:
	virsh --connect "$(SESH)" destroy "$(NAME)" || true
	virsh --connect "$(SESH)" undefine "$(NAME)" || true
	sudo rm -rf ./builds
