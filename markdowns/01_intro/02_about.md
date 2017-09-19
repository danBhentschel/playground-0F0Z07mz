# What is a disk partition?
A partition is a portion of a block device. If you think in terms of architecture, a partition is a temporary wall used to
separate parts of a large room into smaller pseudo-rooms, such as cubicles.

![Image of cubicles](cubicle.jpg "A cubicle")

Partitions in block devices are similar in that they take a large, (usually) **physical** block device and segment it into multiple
smaller, **logical** block devices. Each logical block device is called a partition.

# Characteristics of a partition
A partition:

 * Is a portion of a single larger block device
 * Is comprised of contiguous data blocks
 * Cannot be trivially moved or resized

# Partitioning schemes
There are [a number of partitioning schemes](https://unix.stackexchange.com/q/289389) in existence, but the vast majority of them
are so archaic as to be only a curiosity today. In general practice you will only need to know about two partitioning schemes:
[MBR](https://en.wikipedia.org/wiki/Master_boot_record) and [GPT](https://en.wikipedia.org/wiki/GUID_Partition_Table).
