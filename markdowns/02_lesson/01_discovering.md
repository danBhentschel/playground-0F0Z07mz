# Discovering disk partitions

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 1'"})

First command...

```
lsblk
```

This command should be very familiar to you if you completed the 101 course on block devices. It shows three
partitions &mdash; `sda1`, `sdb1`, and `sdb2` &mdash; mounted on `/`, `/scripts`, and `/pool`.

You get much the same information from the `partitions` file in the `/proc` directory...

```
cat /proc/partitions
```

This also shows the same three partitions, but the data is in a somewhat less readable format.

You can get some more useful information about the filesystems on the mounted partitions with the command...

```
lsblk -f
```

This provides you with the type of filesystem (all `ext4` in this case) the filesystem label, and the UUIDs.

You can also see these UUIDs, and the paritions they map to, by examining the symbolic links in the `/dev/disk/by-uuid` directory...

```
ls -l /dev/disk/by-uuid/
```

Similarly, you can see physical disk identifiers and their mappings by examining the symbolic links in `/dev/disk/by-id`...

```
ls -l /dev/disk/by-id/
```

In this VM, all the disks are identified as `ata-QEMU_HARDDISK_QM0000#`. This identifier is created by the
[QEMU](https://en.wikipedia.org/wiki/QEMU) hypervisor. On a real machine with physical drives, you would get a more
meaningful identifier. Here are some examples of identifiers for disks from different vendors:

```
ata-ST3000DM001-1CH166_W1F44SKX
ata-HGST_HUS726060ALA640_AR31051EJK4JUJ
ata-WDC_WD60EFRX-68MYMN1_WD-WX61DA4F07SC
ata-Hitachi_HUA723030ALA640_MK0371YHH0S4WA
ata-ADATA_SP550_2G0420003056
ata-Samsung_SSD_850_EVO_250GB_S21NNSAG841280B
```

These example identifiers include the manufacturer (the first one is Seagate Technology) the model number, and the serial number.

Next, try the command...

```
sudo fdisk -l
```

> **TIP:** Remember from the 101 course that `sudo` is required to escalate privleges for commands that need to directly access the block devices.

The output of `fdisk -l` shows all block devices and their associated partition tables. Notice that it's separated into two sections, one for `/dev/sda: 1.4 GiB` and one for `/dev/sdb: 100 MiB`. You can see that `sda` has a reported "Disklable type" of `dos` (MBR) and `sdb` reports `gpt`. Also, `sda` shows a single partition of size `1.4G`, and `sdb` shows two partions of sizes `3M` and `97M`.

The final command we're going to try is...

```
sudo parted -l
```

The output from `parted` is very similar to that of `fdisk`. You will see much of the same information, with a few differences. Notice that for both commands, the partition table for the MBR disk has different columns from the GPT table. This is because the two technologies use somewhat different metadata for partitions. 
