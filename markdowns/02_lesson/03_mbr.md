# MBR Partitions

This lesson will focus on creating MBR partitions, and some of the limitations in the MBR
partitioning scheme.

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 3'"})

## Setup loop device

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

## Initializing the partition table

Notice the message `fdisk` gives you:

```
The size of this disk is 3 TiB (3298534883328 bytes). DOS partition table format can not be used on drives for volumes larger than 2199023255040 bytes for 512-byte sectors. Use GUID partition table format (GPT).
```

Even after giving you this message, though, `fdisk` proceeds to create an MBR partition table automatically:

```
Created a new DOS disklabel with disk identifier 0x<ID_HERE>.
```

> **TIP:** The changes you make in `fdisk` do not affect the disk at all until you issue the `w` (**write**) command. Until written, all changes occur
only in memory. You can create and delete partitions all you want and as long as you don't write those changes to the disk, they will not affect the
system in any way.

## Creating partitions

Let's see what happens if we create a new partition. Type `n` for **new**, then answer the prompts as follows:

 - Partition type: **Enter** (default)
 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+500G`

This should succeed:

```
Created a new partition 1 of type 'Linux' and of size 500 GiB.
```

If you want, you can see your partition with the `p` (**print**) command.

Try creating another partition. Type `n` again, and then:

 - Partition type: **Enter**
 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+2T`

It seems like this should work. The device is 3 TiB, and only 0.5 TiB has been allocated for the first partition. But it fails:

```
Value out of range.
```

This is because 2 TiB + 500 GiB would go over the 2 TiB limit imposed by the MBR standard. Instead, try a partition size of `+1500G`. This will be accepted.

## Partition types

Type `t` to change the **type** of a partition. You will be prompted for the partition number to change, and then for a type code. You can type `L` at this
prompt to get a list of all possible partition types. There are 100 options listed. For Linux systems, the most commonly used are:

 - 5 - Extended
 - 82 - Linux swap
 - 83 - Linux
 - 8e - Linux LVM
 - fd - Linux raid

Historically, the partition type was much more important than it is today. Modern Linux distributions are smart enough to figure out the contents of a partition
without this type flag, but they can still be used by the code as a hint to indicate a starting place for content detection.

Try changing the type of one of the partitions to `82`, Linux swap.

## Deleting a partition

Tye `d` to **delete** a partition. You will be prompted for the number of the partition to delete. After deleting a partition, use the `p` command to
verify that it actually is gone.

## Primary and extended

In MBR, you can have:

 - Up to **4 primary** partitions
 - _OR_ **1 extended** partition and up to **3 primary** partitions

If you create an extended partition, then you can create other **logical** partitions inside that extended partition. Try creating an extended
partition now using the `n` command...

 - Partitoin type: `e`
 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+100G`

Look at this partition with the `p` command. Notice that it is automatically given a partition type of `5`, Extended. You can manually change 
this type to something else with the `t` command, but then `fdisk` won't allow you to create logical partitions in it.

## Logical

Now create a logical partition, again with the `n` command:

 - Partition type: `l`
 - First sector: **Enter**
 - Last sector: **Enter**

> **NOTE:** You can't assign partition numbers for logical patitions. They are automatically assigned.

## Partition limitations

Play around a bit with the limitations of MBR partitions. Can you create a logical partition in something other than an extended partition?
Can you create more than 1 extended partition? How about more than 4 primary partitions? Can you create a logical partition that is bigger
than the extended partition? What happens to partition numbers when you delete logical partitions?

## Seeing the results

When you are done, go ahead and execute the `w` command to **write** the changes to disk. This will exit the `fdisk` program. Now do the following...

```
sudo partprobe /dev/loop0
```

Followed by...

```
lsblk
```

Do you see your new partitions in the list?
