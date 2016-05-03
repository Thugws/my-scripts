#!/bin/bash
######################################################################
## Simple script to make backups to google drive useing "rsunc"      #
## The main feature is to have 3 coppys on gdrive                    #
## How much backups to have can be set here  /sed '1,3d'/            #
## it mean that we leave 3 lines from file list other will be deleted#
######################################################################
echo "Staring backup to Gdrive useing rclone"
echo "if directory exist backup have to be created"
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
#cp -r /lib/ /home/home/backup
#cp -r /usr /home/home/backup
#cp /var/lib/libvirt/images/vs.img /home/home/backup
mysqldump -u root -pXXXXXX --all-databases> /home/home/backup/dump-$( date '+%Y-%m-%d_%H-%M-%S' ).sql
zip -r /home/home/"backup-$(date +"%Y-%m-%d").zip" /home/home/backup/
rclone copy /home/home/backup-*.zip gdrive:backup
rm -rf /home/home/backup/*
rm /home/home/backup-*
sleep 60
rclone ls gdrive:backup | cut -c 11- | sed '1,3d' >>/tmp/cleandrive.txt
clean1=$(sed '1!D' /tmp/cleandrive.txt)
clean2=$(sed '2!D' /tmp/cleandrive.txt)
clean3=$(sed '3!D' /tmp/cleandrive.txt)
clean4=$(sed '4!D' /tmp/cleandrive.txt)
clean5=$(sed '5!D' /tmp/cleandrive.txt)
	cleandrive=/tmp/cleandrive.txt
	if [ -f $cleandrive ];
		then echo "File /tmp/cleandrive.txt created succsesfull"
        else
        	echo "File /tmp/cleandrive.txt  does not exist."
        fi
			if [ -n "$clean1" ]
			then rclone delete gdrive:backup/$clean1
			else echo "Nothink to delete"
			fi

			if [ -n "$clean2" ]
                        then rclone delete gdrive:backup/$clean2
                        else echo "Nothink to delete"
                        fi

			if [ -n "$clean3" ]
                        then rclone delete gdrive:backup/$clean3
                        else echo "Nothink to delete"
                        fi

			if [ -n "$clean4" ]
                        then rclone delete gdrive:backup/$clean4
                        else echo "Nothink to delete"
                        fi

			if [ -n "$clean5" ]
                        then rclone delete gdrive:backup/$clean5
                        else echo "Nothink to delete"
                        fi
rm /tmp/cleandrive.txt
echo " ____Back up finished succsesfull_____"
exit
