!/usr/bin/bash.sh

dd if=/dev/zero of=floppy.dmg bs=1k count=1440
dev=$(hdiutil attach -nomount floppy.dmg)
newfs_msdos -f 1440 -v floppy $dev

#hdiutil detach $dev

out=$(hdiutil mountvol $dev) 
#dev=$(echo $out | cut -d' ' -f1)
mnt=$(echo $out | cut -d' ' -f2)

echo $dev
echo $mnt
cp autounattend.xml $mnt
ls $mnt

hdiutil detach $dev

rm floppy.flp 
mv floppy.dmg floppy.flp
