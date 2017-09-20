# Discovering disk partitions

@[Start the VM]({"command":"/bin/bash -c '/project/target/lesson.sh 1'"})

First command...

```
lsblk
```

This command should be very familiar to you if you completed the 101 course on block devices. It shows three
partitions &mdash; `sda1`, `sdb1`, and `sdb2` &mdash; mounted on `/`, `/scripts`, and `/pool`.
