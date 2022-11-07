# LSI 9211-8i IT-mode (firmware) flashing USB
## Overview
This builds an image file which, when booted from a USB on a machine with an LSI 9211-8i Host Bus Adapter (HBA), will automatically flash the HBA with IT firmware.

## Disabling LSI BIOS
By default, the flashing utility flashes both firmware and bios. This allows booting from an HBA-attached disk, but may result in slow boot times. To get in faster boot times, but disable booting from the HBA, you can flash just the firmware via `./build.sh --disable-bios`.

## Requirements
- [Docker](https://docs.docker.com/get-docker/) for building the image
- A USB to write the image to
- An LSI 9211-8i connected to a UEFI motherboard

## Use
These steps are for building on a Linux host. The image can also be built and flashed from a Windows or Mac, but those steps are not listed here.
1. From the project directory, build the image
   ```sh
   # Firmware + BIOS
   ./build.sh

   # Firmware only:
   ./build.sh --disable-bios
   ```
2. Flash the resulting image to a USB
   ```sh
   dd if=flasher.img bs=4M status=progress of=/dev/<your usb>
   ```
3. Boot the USB on the target machine, and wait for the startup script to flash the new firmware
4. Enjoy!

## Debugging
### Requirements
- qemu
### Instructions
Run `./debug.sh` to boot the image with QEMU. While the flashing process will fail, it can be used to debug boot issue with the image and UEFI script

## References
- [sas2flash](https://docs.broadcom.com/doc/12355769)
- [EFI scripting guide](https://web.archive.org/web/20160311073401/https://software.intel.com/en-us/articles/efi-shells-and-scripting/)
- [EFI shell reference](https://web.archive.org/web/20101011170021/http://www.intel.com/software/products/college/efishell/images/efi_shell_cmnd_1_1.pdf)
- [IT firmware flashing guide #1](https://www.ixsystems.com/community/threads/how-to-flash-lsi-9211-8i-using-efi-shell.50902)
- [IT firmware flashing guide #2](https://www.tfir.io/easiest-way-to-flash-lsi-sas-9211-8i-on-motherboards-without-efi-shell)
- [Slow boot times](https://www.ixsystems.com/community/threads/lsi-9211-8i-boots-extremely-slow.50420)
