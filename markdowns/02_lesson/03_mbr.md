# MBR Partitions

This lesson will focus on creating MBR partitions, and some of the limitations in the MBR
partitioning scheme.

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 3'"})

To start off, let's create a 3 TiB loop device...

```
truncate -s 3T /pool/disk1
sudo losetup loop0 /pool/disk1
```

> **TIP:** The `truncate` command creates what is called a [sparse file](https://en.wikipedia.org/wiki/Sparse_file). This doesn't
actually allocate the required disk space until it is used. In this way, you can create files that (claim they) are larger than
the medium they are stored on. This is why we can create a 3 TiB file on a partition that is under 100 MiB in size.

Remember that MBR does not support drives larger than 2 TiB. Let's see what happens when we try to create MBR partitions on
this device...

```
sudo fdisk /dev/loop0
```

Notice the message `fdisk` gives you:

```
The size of this disk is 3 TiB (3298534883328 bytes). DOS partition table format can not be used on drives for volumes larger than 2199023255040 bytes for 512-byte sectors. Use GUID partition table format (GPT).
```

Even after giving you this message, though, `fdisk` proceeds to create an MBR partition table automatically:

```
Created a new DOS disklabel with disk identifier 0x<ID_HERE>.
```

Let's see what happens if we create a new partition. Type `n` for **new**, then answer the prompts as follows:

 - Partition type: **Enter** (default)
 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+500G`

This should succeed:

```
Created a new partition 1 of type 'Linux' and of size 500 GiB.
```

If you want, you can see your partition with the `p` (print) command.

Try creating another partition. Type `n` again, and then:

 - Partition type: **Enter**
 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+2T`

This should work. The device is 3 TiB, and only 0.5 TiB has been allocated for the first partition. But it fails:

```
Value out of range.
```

This is because 2 TiB + 500 GiB would go over the 2 TiB limit imposed by the MBR standard. Instead, try a partition size of `+1499G`. This should work.
