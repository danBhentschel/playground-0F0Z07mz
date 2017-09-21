# MBR: Out with the old
The MBR (Master Boot Record) partitioning scheme originated in the 1983 release of IBM PC DOS 2.0. As such, the MBR partition table is also
commonly referred to as the **dos** or **msdos** partition table.

MBR is over 30 years old, and it shows its age in its limitations:

 * Does not support block devices larger than 2 TiB in size
 * Maximum of 4 (primary) partitions per device
 * Size of the bootstrap code must be 440 bytes (or less)
 * No checksums or redundancy (in standard implementations)

# GPT: In with the new
The GPT (GUID Partition Table) scheme was introduced in the early 2000s, and addressed all of the limitations of MBR listed
above. This newer scheme:

 * Supports block devices up to 8 ZiB in size (very, very big)
 * Supports at least 128 partitions per device
 * Supports variable sized bootstrap code
 * Requires that two copies of the partition table must exist
 * Requires a CRC on both the GPT header and the table entries

Given all of these improvements, it seems logical that MBR should have disappeared long ago. Unfortunately, it's
still around, for two major reasons:

 1. Windows OSs will only boot from MBR disks on machines that use BIOS (as opposed to UEFI) firmware
 2. The standard installed partitioning tool on Linux (fdisk) creates MBR partitions by default

