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

Notice the message fdisk gives you:

```

```
