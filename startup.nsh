# Disable command echoing
@echo -off

# Find startup device, necessary to get files from the root directory
for %i run (1 10)
  set root "fs%i%:"
  if exist "%root%\sas2flash.efi" then
    goto deviceFound
  endif
endfor

echo "*************************************************************"
echo "*** ERROR: could not find device with file: sas2flash.efi ***"
echo "*************************************************************"
goto end

:deviceFound

# Try to erase existing firmware
echo "*********************************"
echo "*** Erasing existing firmware ***"
echo "*********************************"
echo " "
sas2flash.efi -o -e 6

# Exit on error
if not %LastError% == 0 then
    echo " "
    echo "*********************************************************************"
    echo "*** ERROR: Could not erase old firmware, abandoning IT-mode flash ***"
    echo "*********************************************************************"
	goto end
endif

echo " "
if exist "%root%\disable_bios" then
    # Flash firmware only, allowing faster boot times (but no booting from HBA-attached disks)
    echo "*****************************************"
    echo "*** Flashing IT firmware without BIOS ***"
    echo "*****************************************"
    echo " "

    sas2flash.efi -o -f 2118it.bin
else
    # Flash firmware + BIOS, allowing booting from an HBA-attached disk
    echo "**************************************"
    echo "*** Flashing IT firmware with BIOS ***"
    echo "**************************************"
    echo " "

    sas2flash.efi -o -f 2118it.bin -b mptsas2.rom
endif

# Exit on error
if not %LastError% == 0 then
    echo " "
    echo "*******************************************"
    echo "*** ERROR: Could flash IT-mode firmware ***"
    echo "*******************************************"
	goto end
endif

echo " "
echo "********************************************"
echo "*** Displaying HBA info for verification ***"
echo "********************************************"
echo " "
sas2flash.efi -listall

echo " "
echo "******************************************************************"
echo "*** IT firmware flashed, remove USB and type `reset` to reboot ***"
echo "******************************************************************"

:end
