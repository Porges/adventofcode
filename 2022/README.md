# 2022

Note that the devcontainer is set up with the appropriate software.

# Day 1 – Awk

```console
$ awk -f day-01-a.awk < input1.txt
$ awk -f day-02-a.awk < input1.txt
```

# Day 2 – Snobol

```console	
$ snobol4 day-02-a.sno < input2.txt
$ snobol4 day-02-b.sno < input2.txt
```

# Day 3 – Mumps/M

Had to change naming scheme as mumps doesn’t allow hyphens in the filenames.

```console
$ export gtm_dist=/usr/lib/x86_64-linux-gnu/fis-gtm/V6.3-014_x86_64
$ $gtm_dist/mumps -run day03a < input3.txt
$ $gtm_dist/mumps -run day03b < input3.txt
```

# Day 4 – Befunge 98

```console
$ cfunge -S day-04-a.bf98 < input4.txt
$ cfunge -S day-04-b.bf98 < input4.txt
```

# Day 5 – Haskell

```console
$ runghc day-05-a.hs < input5.txt
$ runghc day-05-b.hs < input5.txt
```
