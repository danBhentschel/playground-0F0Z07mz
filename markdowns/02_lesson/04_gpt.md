# GPT Partitions

This lesson will focus on creating GPT partitions.

> **TIP:** You might want to
<a href="https://tech.io/playgrounds/460370c032058ec25ad94748542e11273283/linux-filesystems-102---partitions/gpt-partitions" target="_blank">open a new window</a>
to this page so that you can view the terminal and the instructions side-by-side.

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 4'"})

## Setup loop device

Again, we will start off by creating a 3 TiB loop device...

```
truncate -s 3T /pool/disk1
sudo losetup loop0 /pool/disk1
```

Now let's edit the partition table on this device in `fdisk`...

```
sudo fdisk /dev/loop0
```

## Initializing the partition table

Just as before, `fdisk` creates an MBR table automatically:

```
Created a new DOS disklabel with disk identifier 0x<ID_HERE>.
```

We can tell `fdisk` to create a new GPT partition table on the device with the `g` (create **GPT** partition table) command. You should get the
following response:

```
Created a new GPT disklabel (GUID: <ID_HERE>).
```

## Creating partitions

Some of this will be similar to what we did in the MBR section, but there will be some definite differences.

Let's see what happens if we create a new partition. Type `n` for **new**, then answer the prompts as follows:

 - Partition number: **Enter** (default)
 - First sector: **Enter**
 - Last sector: `+500G`

> **NOTE:** Unlike with MBR partitions, you were not prompted for a "Partition type" (primary, extended, or logical). Since
GPT supports at least 128 partitions, there is no need for extended or logical partitions.

This should succeed:

```
Created a new partition 1 of type 'Linux filesystem' and of size 500 GiB.
```

If you want, you can see your partition with the `p` (**print**) command.

Try creating another partition. Type `n` again, and then:

 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+2T`

Remember when this failed in the MBR section? Not here. GPT has no problem with creating this partition.

## Partition types

Type `t` to change the **type** of a partition. You will be prompted for the partition number to change, and then for a type code. You can type `L` at this
prompt to get a list of all possible partition types.

Notice that each of the listed types has a GUID to the right of it. That's because in GPT, partition types are identified by a 128-bit value, rather than an
8-bit value, as in MBR. The main advantage of this is that a new partition type identifier can be defined simpy by generating a new GUID, and it is statistically
imporbable that the identifier will conflict with any previously existing identifier.

There is a drawback to using GUIDs for partition types, though: they are a pain to type. And so `fdisk` provides an index to the left of each partition type.
This is a more convenient way to identify partition types from the command line. Here are some of the more common Linux GPT partition types, and their `fdisk`
indices:

 - `1` - EFI System
 - `4` - BIOS boot
 - `19` - Linux swap
 - `20` - Linux filesystem
 - `28` - Linux RAID
 - `30` - Linux LVM

Try changing the type of one of the partitions to `19`, Linux swap.

> **NOTE:** The EFI System and BIOS boot partition types are used to store a bootloaders for UEFI or BIOS firmware. A discussion of bootloaders and
boot partitions is beyond the scope of this course.

## Partition names

In addition to a partition number and type, GPT also allows you to name your partitions. In `fdisk`, this must be done through the **extra functionality**
menu, which can be accessed with the `x` command. Once you have switched menus, use the `n` command to change a partition **name**, and then enter:

 - Partition number: `1`
 - New name: `My 1st partition`

You should see the message:

```
Partition name changed from '' to 'My 1st partition'.
```

Before moving on, type the `r` command to **return** to the main menu.

## Detailed partition information
The `i` (**information**) command will give you detailed information about a partition. Try it now on the partition you just renamed. Do you see the
partition name?

## Deleting a partition

Tye `d` to **delete** a partition. You will be prompted for the number of the partition to delete. After deleting a partition, use the `p` command to
verify that it actually is gone.

## Partition limitations

Play around a bit with the limitations of GPT partitions. Can you create more than 4 partitions? Are there any restrictions on what you are allowed to do?

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
