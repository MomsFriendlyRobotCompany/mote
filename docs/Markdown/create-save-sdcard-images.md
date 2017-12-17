# Creating and Saving SD Card Images

## Creating

Use [Etcher](https://etcher.io/) to burn a disk image onto your SD card.

## Saving

Once you setup an image (install everything you want onto the default raspbian
image), you can save a copy of it.

1. First figure our what disk your sd card is with `diskutil`:
  kevin@Dalek ~ $ diskutil list
  /dev/disk0 (internal, physical):
  #:                       TYPE NAME                    SIZE       IDENTIFIER
  0:      GUID_partition_scheme                        \*500.1 GB   disk0
  1:                        EFI EFI                     209.7 MB   disk0s1
  2:                  Apple_HFS Dalek                   499.2 GB   disk0s2
  3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3

  /dev/disk1 (external, physical):
  #:                       TYPE NAME                    SIZE       IDENTIFIER
  0:      GUID_partition_scheme                        \*2.0 TB     disk1
  1:                        EFI EFI                     209.7 MB   disk1s1
  2:                  Apple_HFS Sonic                   2.0 TB     disk1s2

  /dev/disk3 (internal, physical):
  #:                       TYPE NAME                    SIZE       IDENTIFIER
  0:     FDisk_partition_scheme                        \*15.9 GB    disk3
  1:             Windows_FAT_32 boot                    43.8 MB    disk3s1
  2:                      Linux                         15.9 GB    disk3s2
1. You probably have the `/boot` drive mounted, unmount it with: `diskutil unmountDisk /dev/disk3`. Note, `/dev/disk3` is my SD card from the step above. Change yours
as needed.
1. Save your image with: `sudo dd if=/dev/rdisk3 of=/path/to/image.img bs=1m`
    1. **if** is input file. Note here we use `rdisk` instead of `disk`.
    1. **of** is output file. You can call it anything you want and give it a path.

Now you can burn this image to other SD cards using etcher above.
