# Working with loop devices

In Linux, a [loop device](https://en.wikipedia.org/wiki/Loop_device) is a method of manipulating a file on disk as though it is
a block device. We will use loop devices in this course, and in other courses in the **Linux Filesystems** series, to simulate
operations on block devices. This section will teach you how to work with loop devices.

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 2'"})

Let's start by double-checking the current block devices and filesystems on the VM...

```
lsblk -f
```

As you can see, there are two block devices, `sda` and `sdb`, with 3 mounted partitions. Let's create a new 10 MiB (loop)
block device. We start by creating a 10 MiB file in the `/pool` directory...

```
truncate -s 10M /pool/disk1
```

We should check to make sure the file was created correctly...

```
ls -lh /pool
```

Yep, the file is there. Let's create a loop device for it...

```
sudo losetup loop0 /pool/disk1
```

There's no feedback from this, so let's check to see if the block device is there...

```
lsblk -f
```

See the new `loop0` device in the list? It doesn't have any partitions or filesystems associated with it, though.
So let's create a partition now...

```
sudo fdisk /dev/loop0
```

The `fdisk` command informs you that there is no partition table on the device, and helpfully creates an MBR
partition table for you:

```
Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x<ID_HERE>.
```

You should now be at a `Command` prompt. Type `n` to create a new partition. You will be prompted for partition type,
number, start, and end. Just press **Enter** four times to accept the default for each prompt. Then type `w` to write
the changes to the partition table. You should see the following message:

```
Created a new partition 1 of type 'Linux' and of size 9 MiB.
```

The `fdisk` output also helpfully prompts you to run `partprobe`, so let's do that now...

```
sudo partprobe /dev/loop0
```

And let's take another look at our block devices...

```
lsblk -f
```

If all has gone according to plan, you should see a `loop0p1` partition "hanging" off the `loop0` device.

Go ahead and format it with an **ext4** filesystem...

```
sudo mkfs.ext4 /dev/loop0p1
```

And then mount it on `/mnt`...

```
sudo mount /dev/loop0p1 /mnt
```

And let's do one final check...

```
lsblk -f
```

Look at that! Your `/pool/disk` file is now mounted on `/mnt` using the loopback device, `loop0`.
