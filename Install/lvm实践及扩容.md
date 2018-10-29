# lvm磁盘使用

## 查看所有磁盘



```
root@233:~# fdisk -l

########   略    #####################


Disk /dev/vda: 40 GiB, 42949672960 bytes, 83886080 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xcd5caf0d

Device     Boot Start      End  Sectors Size Id Type
/dev/vda1  *     2048 83886079 83884032  40G 83 Linux

Disk /dev/vdb: 30 GiB, 32212254720 bytes, 62914560 sectors      # 新的磁盘在这里
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

## 格式化磁盘操作



n =====>>  回车 =======>>  t  ========>> 回车 =========>> t  =========>> L =======>>w=====>> w



<a href="https://imgchr.com/i/i2ehTI"><img src="https://s1.ax1x.com/2018/10/29/i2ehTI.md.png" alt="i2ehTI.png" border="0" /></a>





```
root@233:~# fdisk /dev/vdb

Welcome to fdisk (util-linux 2.27.1).
#####略######
Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p):

Using default response p.
Partition number (1-4, default 1):
First sector (2048-62914559, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-62914559, default 62914559): t
Last sector, +sectors or +size{K,M,G,T,P} (2048-62914559, default 62914559):

Created a new partition 1 of type 'Linux' and of size 30 GiB.

Command (m for help): t
Selected partition 1
Partition type (type L to list all types): l

 0  Empty           24  NEC DOS         81  Minix / old Lin bf  Solaris
 1  FAT12           27  Hidden NTFS Win 82  Linux swap / So c1  DRDOS/sec (FAT-
 2  XENIX root      39  Plan 9          83  Linux           c4  DRDOS/sec (FAT-
 3  XENIX usr       3c  PartitionMagic  84  OS/2 hidden or  c6  DRDOS/sec (FAT-
 4  FAT16 <32M      40  Venix 80286     85  Linux extended  c7  Syrinx
 5  Extended        41  PPC PReP Boot   86  NTFS volume set da  Non-FS data
 6  FAT16           42  SFS             87  NTFS volume set db  CP/M / CTOS / .
 7  HPFS/NTFS/exFAT 4d  QNX4.x          88  Linux plaintext de  Dell Utility
 8  AIX             4e  QNX4.x 2nd part 8e  Linux LVM       df  BootIt
 9  AIX bootable    4f  QNX4.x 3rd part 93  Amoeba          e1  DOS access
 a  OS/2 Boot Manag 50  OnTrack DM      94  Amoeba BBT      e3  DOS R/O
 b  W95 FAT32       51  OnTrack DM6 Aux 9f  BSD/OS          e4  SpeedStor
 c  W95 FAT32 (LBA) 52  CP/M            a0  IBM Thinkpad hi ea  Rufus alignment
 e  W95 FAT16 (LBA) 53  OnTrack DM6 Aux a5  FreeBSD         eb  BeOS fs
 f  W95 Ext'd (LBA) 54  OnTrackDM6      a6  OpenBSD         ee  GPT
10  OPUS            55  EZ-Drive        a7  NeXTSTEP        ef  EFI (FAT-12/16/
11  Hidden FAT12    56  Golden Bow      a8  Darwin UFS      f0  Linux/PA-RISC b
12  Compaq diagnost 5c  Priam Edisk     a9  NetBSD          f1  SpeedStor
14  Hidden FAT16 <3 61  SpeedStor       ab  Darwin boot     f4  SpeedStor
16  Hidden FAT16    63  GNU HURD or Sys af  HFS / HFS+      f2  DOS secondary
17  Hidden HPFS/NTF 64  Novell Netware  b7  BSDI fs         fb  VMware VMFS
18  AST SmartSleep  65  Novell Netware  b8  BSDI swap       fc  VMware VMKCORE
1b  Hidden W95 FAT3 70  DiskSecure Mult bb  Boot Wizard hid fd  Linux raid auto
1c  Hidden W95 FAT3 75  PC/IX           bc  Acronis FAT32 L fe  LANstep
1e  Hidden W95 FAT1 80  Old Minix       be  Solaris boot    ff  BBT
Partition type (type L to list all types): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

## 查看格式化之后的分区

```
root@233:~# fdisk -l

#########省略########

Device     Boot Start      End  Sectors Size Id Type
/dev/vdb1        2048 62914559 62912512  30G 8e Linux LVM
```

## 准备物理卷pv

```
root@233:~# pvcreate /dev/vdb1
  Physical volume "/dev/vdb1" successfully created
```

## 检查物理卷创建情况

```
root@233:~# pvcreate /dev/vdb1
  Physical volume "/dev/vdb1" successfully created
root@233:~# pvdisplay
  "/dev/vdb1" is a new physical volume of "30.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/vdb1
  VG Name
  PV Size               30.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               1AZidu-V1EW-PuiZ-YnVD-Vg2O-Lhn3-VrweQb
```

## 准备卷组

下列命令用来创建名为'volume-group1'的卷组，使用/dev/sdb1, /dev/sdb2 和 /dev/sdb3创建。

```
root@233:~# vgcreate volume-group1 /dev/vdb1
  Volume group "volume-group1" successfully created
```

### 其余写法

```
  root@233:~# vgcreate volume-group1 /dev/sdb1 /dev/sdb2 /dev/sdb3
```

## 检查卷组

```
root@233:~# vgdisplay
  --- Volume group ---
  VG Name               volume-group1
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               30.00 GiB
  PE Size               4.00 MiB
  Total PE              7679
  Alloc PE / Size       0 / 0
  Free  PE / Size       7679 / 30.00 GiB
  VG UUID               PbbkhX-Zv8D-d5yq-3GqW-IIr8-dKh1-VDhvkf
```

## 创建逻辑卷juan1

```
root@233:~# lvcreate -L 10G -n  juan1   volume-group1
  Logical volume "l1" created.
```

## 查看逻辑卷

  - ```
      root@233:~# lvdisplay
        --- Logical volume ---
        LV Path                /dev/volume-group1/juan1
        LV Name                l1
        VG Name                volume-group1
        LV UUID                NmTSrc-j0m3-TQdC-E9PY-0Spy-sxlt-hviMUx
        LV Write Access        read/write
        LV Creation host, time 233, 2018-10-29 17:05:33 +0800
        LV Status              available
      
      # open                 0
      
        LV Size                10.00 GiB
        Current LE             2560
        Segments               1
        Allocation             inherit
        Read ahead sectors     auto
      
      - currently set to     256
        Block device           252:0
      ```

## 格式化和挂载逻辑卷

1. ```
   root@233:~# mkfs.ext4 /dev/volume-group1/juan1
   mke2fs 1.42.13 (17-May-2015)
   Creating filesystem with 2621440 4k blocks and 655360 inodes
   Filesystem UUID: a7bfe8d0-f189-4cbb-9482-a824c0ab0eee
   Superblock backups stored on blocks:
   	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
   
   Allocating group tables: done
   Writing inode tables: done
   Creating journal (32768 blocks): done
   Writing superblocks and filesystem accounting information: done
   ```



   ```
   root@233:~# mkdir /lvm-mount
   root@233:~# mount /dev/volume-group1/juan1  /lvm-mount/
   ```


## 看结果？

```
root@233:~# df -HT
Filesystem                       Type      Size  Used Avail Use% Mounted on
udev                             devtmpfs  2.1G     0  2.1G   0% /dev
tmpfs                            tmpfs     415M  8.4M  407M   3% /run
/dev/vda1                        ext4       43G  2.1G   38G   6% /
tmpfs                            tmpfs     2.1G   17k  2.1G   1% /dev/shm
tmpfs                            tmpfs     5.3M     0  5.3M   0% /run/lock
tmpfs                            tmpfs     2.1G     0  2.1G   0% /sys/fs/cgroup
tmpfs                            tmpfs     415M     0  415M   0% /run/user/0
/dev/mapper/volume--group1-juan1 ext4       11G   24M  9.9G   1% /lvm-mount   # 挂载成功
```



# 扩展一个LVM卷

## 先卸载掉之前的卷组

```
# umount /lvm-mount/ 
```



## 然后增大卷的大小

```
root@233:~# lvextend -L +5G /dev/mapper/volume--group1-juan1
```

## 接下来，检查磁盘错误（必须的）

```
# e2fsck -f /dev/volume-group1/juan1
```

## 更新磁盘格式

```
root@233:~# resize2fs /dev/mapper/volume--group1-juan1
e2fsck 1.42.13 (17-May-2015)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/volume-group1/juan1: 11/655360 files (0.0% non-contiguous), 79663/2621440 blocks
```

## 检查lv的状态

  - ```
      root@233:~# lvdisplay
        --- Logical volume ---
        LV Path                /dev/volume-group1/juan1
        LV Name                juan1
        VG Name                volume-group1
        LV UUID                pykwMR-MbwW-2AnB-JUbz-zXYf-EPie-TQ26TH
        LV Write Access        read/write
        LV Creation host, time 233, 2018-10-29 17:12:42 +0800
        LV Status              available
      
      # open                 0
      
        LV Size                20.00 GiB
        Current LE             5120
        Segments               1
        Allocation             inherit
        Read ahead sectors     auto
      
      - currently set to     256
        Block device           252:0
      ```



## 卷组将会变小

```
root@233:~# vgdisplay
  --- Volume group ---
  VG Name               volume-group1
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  9
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               30.00 GiB
  PE Size               4.00 MiB
  Total PE              7679
  Alloc PE / Size       7168 / 28.00 GiB
  Free  PE / Size       511 / 2.00 GiB  #剩余2G
  VG UUID               PbbkhX-Zv8D-d5yq-3GqW-IIr8-dKh1-VDhvkf
```



## 继续挂载

```
root@233:~# mount /dev/volume-group1/juan1  /lvm-mount/
root@233:~# df -h
Filesystem                        Size  Used Avail Use% Mounted on
udev                              2.0G     0  2.0G   0% /dev
tmpfs                             396M  8.0M  388M   3% /run
/dev/vda1                          40G  2.0G   36G   6% /
tmpfs                             2.0G   16K  2.0G   1% /dev/shm
tmpfs                             5.0M     0  5.0M   0% /run/lock
tmpfs                             2.0G     0  2.0G   0% /sys/fs/cgroup
tmpfs                             396M     0  396M   0% /run/user/0
/dev/mapper/volume--group1-juan1   28G   28M   26G   1% /lvm-mount
```



# 缩小一个LVM卷



## 卸载掉

```
umount  /lvm-mount/
```



## 直接缩小

```
root@233:~# lvreduce -L -5G /dev/mapper/volume--group1-juan1
  WARNING: Reducing active and open logical volume to 23.00 GiB
  THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce juan1? [y/n]: y
  Size of logical volume volume-group1/juan1 changed from 28.00 GiB (7168 extents) to 23.00 GiB (5888 extents).
  Logical volume juan1 successfully resized.
```



后面不写了，不建议缩小，大概率会丢失数据



# 参考删除命令

## 删除物理卷

```
# pvremove /dev/sdb1 
```

## 删除卷组

```
# vgremove volume-group1 
```

## 删除逻辑卷

```
# umount /lvm-mount/  #有时可能需要卸载掉
# lvremove /dev/volume-group1/juan1
```















