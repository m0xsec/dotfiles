#!/bin/sh
# This script will resign various kernel modules after a kernel update.
# The joys of linux and secure boot!

# Make sure these keys are imported into the system keyring
export PRIV_KEY="/home/m0x/.ssl/MOK.priv"
export DER_KEY="/home/m0x/.ssl/MOK.der"

echo "Make sure to use this script with root privileges, and make sure to be in non-graphical mode."
echo "You can set non-graphical mode with the following command, then reboot:"
echo "sudo systemctl set-default multi-user.target"
echo "----------------------------------------------------"

# VMWare Kernel Modules
echo "Resigning VMWare Kernel Modules"
echo "Note: if modules aren't found, you will need to recompile them from the ~/git/vmware-host-modules git repo!"
# TODO: Pull current kernel version insteaed of hardcoding
/usr/src/kernels/5.16.8-200.fc35.x86_64/scripts/sign-file sha256 $PRIV_KEY $DER_KEY $(modinfo -n vmmon)
/usr/src/kernels/5.16.8-200.fc35.x86_64/scripts/sign-file sha256 $PRIV_KEY $DER_KEY $(modinfo -n vmnet)

# NVIDIA Drivers & Kernel Modules
echo "Resigning NVIDIA Drivers & Kernel Modules"
# TODO: Hardcode NVIDIA driver version/path?
/home/m0x/nvidia/NVIDIA-Linux-x86_64-510.47.03.run -s --module-signing-secret-key=$PRIV_KEY --module-signing-public-key=$DER_KEY

# Generate updated grub2 and initramfs for NVIDIA DRM
# Enable NVIDIA DRM in grub2 by adding the following to the end of GRUB_CMDLINE_LINUX in /etc/default/grub:
# rd.driver.blacklist=nouveau nvidia-drm.modeset=1
echo "Dealing with NVIDIA DRM modset (grub2, initramfs)"
grub2-mkconfig -o /boot/grub2/grub.cfg
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-backup.img
dracut /boot/initramfs-$(uname -r).img $(uname -r)


echo "kthxbai <3"
echo "You should enable graphical mode and reboot, you can do that with the command below:"
echo "sudo systemctl set-default graphical.target; reboot"
