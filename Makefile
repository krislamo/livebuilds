.PHONY: build install clean

DIST := trixie
INFO := debian13
ISO  := $(shell readlink -f ./builds/trixie/live-image-amd64.hybrid.iso)
NAME := live_$(DIST)
MEM  := 16384
CPU  := 2

default: build

build:
	mkdir -p builds/$(DIST)
	cd builds/$(DIST) && \
	lb config \
		--distribution $(DIST) \
		--debian-installer live && \
	sudo lb build

install:
	virt-install --connect qemu:///session \
	  --name "$(NAME)" \
	  --osinfo "$(INFO)" \
	  --machine q35 \
	  --memory "$(MEM)" --vcpus "$(CPU)" \
	  --cpu host-model --virt-type kvm \
	  --cdrom "$(ISO)" \
	  --disk none \
	  --network none \
	  --graphics spice,listen=127.0.0.1 \
	  --video virtio \
	  --noautoconsole

clean:
	virsh --connect qemu:///session \
		undefine --nvram --snapshots-metadata "$(NAME)" || true
	sudo rm -rf ./builds
