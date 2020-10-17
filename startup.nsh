# Disable command echoing
@echo -off

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
echo "****************************"
echo "*** Flashing IT firmware ***"
echo "****************************"
echo " "
sas2flash.efi -o -f 2118it.bin -b mptsas2.rom

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
