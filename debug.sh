#!/bin/sh
# This is for debugging the UEFI boot process & script, and is only expected to be run during development

IMG=flasher.img

# debian
ovmf="/usr/share/OVMF/OVMF_CODE.fd"
if [ ! -e "$ovmf" ]; then
    # arch
    ovmf="/usr/share/ovmf/x64/OVMF_CODE.fd"
fi

qemu-system-x86_64 -m 2048 -nographic --enable-kvm -bios "$ovmf" -cpu host -drive format=raw,file="$IMG"
