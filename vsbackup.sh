#!/bin/bash
echo "Staring backup to Gdrive useing rclone"
echo "if directory exist backup have to be created"
p=$(/usr/bin/fping 10.1.1.1)
echo "$p"
if [ "$p" != "10.1.1.1 is alive"  ]
then
/home/home/script/slack.sh ITS_impsible_to_backup_vpn_link_is_down
else
mount.nfs 10.1.1.1:/var/vsbackup /mnt/mz 
backupdir="/home/home/backup"
        if [ -e "$backupdir" ]
                then
                        echo "BAckup directory exist lets clear it to be shure its cleare"
                           if [ -e "$backupdir" ]
                           then
                           rm -rf /home/home/backup/*
                else
                        mkdir /home/home/backup
           fi
        fi
cp -r /etc/ /home/home/backup
cp -r /var/www/ /home/home/backup
cp -r /bin/ /home/home/backup
cp -r /boot/ /home/home/backup
cp -r /lib/ /home/home/backup
cp -r /usr /home/home/backup
cp /var/lib/libvirt/images/vs.img /home/home/backup
mysqldump -u root -polehwgoleh --all-databases> /home/home/backup/dump-$( date '+%Y-%m-%d_%H-%M-%S' ).sql
zip -r /home/home/"backup-$(date +"%Y-%m-%d").zip" /home/home/backup/
cp /home/home/backup-*.zip /mnt/mz
rm -rf /home/home/backup/*
rm /home/home/backup-*
umount /mnt/mz
/home/home/script/slack.sh Succssesful_vsbackup_finished
fi
exit
