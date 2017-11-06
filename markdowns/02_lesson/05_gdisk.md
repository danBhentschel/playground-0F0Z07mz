# GPT Partitions With `gdisk`

This lesson will focus on creating GPT partitions using the `gdisk` application. The `gdisk` interface and workflow are similar to `fdisk`'s, but are
designed specifically for working with GPT paritions.

> **TIP:** You might want to
<a href="https://tech.io/playgrounds/460370c032058ec25ad94748542e11273283/linux-filesystems-102---partitions/gpt-partitions" target="_blank">open a new window</a>
to this page so that you can view the terminal and the instructions side-by-side.

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 5'"})

## Setup loop device

Again, we will start off by creating a 3 TiB loop device...

```
truncate -s 3T /pool/disk1
sudo losetup loop0 /pool/disk1
```

Now let's edit the partition table on this device in `gdisk`. Before we can do that, we need to install the application. The 16.04 release of
Ubuntu doesn't come with `gdisk` pre-installed. Type the following command...

```
sudo apt-get install gdisk
```

Now we can launch `gdisk`...

```
sudo gdisk /dev/loop0
```

## Initializing the partition table

Whereas `fdisk` automatically created an MBR partition table on startup, `gdisk` automatically creates a GPT table:

```
Creating new GPT entries.
```

That was easy.

## Creating partitions

Some of this will be similar to what we did with `fdisk`, but there are some differences.

Let's create a new partition. Type `n` for **new**, then answer the prompts as follows:

 - Partition number: **Enter** (default)
 - First sector: **Enter**
 - Last sector: `+500G`
 - Hex code or GUID: **Enter**

This should succeed, though there's no obvious message indicating creation of the partition. Let's examine your new partition with the `p` (**print**) command.
You should see:

```
Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048      1048578047   500.0 GiB   8300  Linux filesystem
```

Try creating another partition. Type `n` again, and then:

 - Partition number: **Enter**
 - First sector: **Enter**
 - Last sector: `+2T`
 - Hex code or GUID: **Enter**

## Partition types

In `gdisk`, you have the opportunity to specify a partition's type (hex code or GUID) at creation time. We used the default, which is **Linux filesystem**,
for both of the partitions created above. You can change the parition **type** with the `t` command.

Type `t`. You will be prompted for the partition number to change, and then for a type code. You can type `L` at this prompt to get a list of all possible
partition types.

In `fdisk`, each parition type was listed with both an index and a GUID. The `gdisk` application doesn't list partition type GUIDs, and it doesn't use
indices. Instead, it makes use of a four-digit "hex code" to identify partition types. Here are some of the more common Linux GPT partition types, and their
`gdisk` hex codes:

 - `ef00` - EFI System
 - `ef02` - BIOS boot
 - `8200` - Linux swap
 - `8300` - Linux filesystem
 - `fd00` - Linux RAID
 - `8e00` - Linux LVM

Try changing the type of one of the partitions to `8200`, Linux swap.

## Partition names

Use the `c` command to **change** a partition name, and then enter:

 - Partition number: `1`
 - New name: `My 1st partition`

You can see the new partition name in the output of the `p` command.

## Detailed partition information

Just as in `fdisk`, the `i` (**information**) command will give you detailed information about a partition.

## Deleting a partition

Type `d` to **delete** a partition. You will be prompted for the number of the partition to delete. After deleting a partition, use the `p` command to
verify that it actually is gone.

## Seeing the results

When you are done, go ahead and execute the `w` command to **write** the changes to disk. You will be prompted:

```
Do you want to proceed? (Y/N):
```

Type `y`, then **Enter**. This will exit the `gdisk` program. Now do the following...

```
sudo partprobe /dev/loop0
```

Followed by...

```
lsblk
```

Do you see your new partitions in the list?
