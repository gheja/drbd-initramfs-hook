drbd-initramfs-hook
===================

Implements an intramfs-tools hook to add DRBD utilities and configuration files to the initramfs when using update-initramfs.

Adds the following files (and their dependencies) to the initramfs image:
  * /sbin/drbdadm
  * /sbin/drbdmeta
  * /sbin/drbdsetup
  * /etc/drbd.conf
  * /etc/drbd.d/*

Also creates the /var/lib/drbd directory.
