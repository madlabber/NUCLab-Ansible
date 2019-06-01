!/usr/bin/bash.sh

dd if=/dev/zero of=floppy.dmg bs=1k count=1440

partition_table=$'778135908,1141509631,0x72,-,357,116,40,357,32,45\n168689522,1936028240,0x65,-,288,115,43,367,114,50\n1869881465,1936028192,0x79,-,366,32,33,357,32,43\n0,-657740800,0x0D,-,372,97,50,0,10,0'

echo "$partition_table" | fdisk -r -y floppy.dmg

dev=$(hdiutil attach -nomount floppy.dmg)

newfs_msdos -v floppy $dev

hdiutil detach $dev

out=$(hdiutil attach floppy.dmg) 
dev=$(echo $out | cut -d' ' -f1)
mnt=$(echo $out | cut -d' ' -f2)

echo $dev
echo $mnt
cp autounattend.xml $mnt
ls $mnt

hdiutil detach $dev

rm floppy.flp 
mv floppy.dmg floppy.flp
