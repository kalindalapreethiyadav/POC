

#!/bin/bash

<<Description
*****************************************************************************************
Tracking & Identifing only High Disk space consumed files in all directories recursively on the Filesystem Paths
******************************************************************************************
Description

exec 1> file_tracking.log 2>&1
FS_PP_ISOM=$(cat FSpaths_PP_ISOM.txt)
FS_PP=$(cat FSpaths_PP.txt)
FS_PP_CTS=$(cat FSpaths_PP_CTS.txt)
FS_P_DS=$(cat FSpaths_P_DS.txt)

Track_file_percent=40 #Providing "%" that how much we need to track based on FS.

echo -e "\e[35m *******Script started on $(date)***********\n \e[0m"

level2_ftrack()
{
echo -e "\e[32m Tracking files > $Track_file_percent% in $1:\n \e[0m"
#Finding the Total size of the fileystem
total_size=$(df $line | awk '{print $2}' | tail -1)
cd $line

#Tracking & identifying Top 10 High disk consumed files only on all directories(including sub -dir) recursivly in the Filesystem Path

for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
        do
        if [ -f "$line" ]; then
            used_fsize=$(ls -lrt $line | awk '{print $5F}')
            fpercent=$((100*$used_fsize/$total_size ))
                if [ $fpercent -ge $Track_file_percent ] ; then
                echo "Total_SIZE = $total_size Used_SIZE = $used_fsize Used_percent = $fpercent  File_Details = $line"
                else
                echo " " > /dev/null #supress the data
                fi
        else
            echo " " > /dev/null
        fi
        done
    }

for line in $FS_PP_ISOM 
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
level2_ftrack $line 
done

sleep 5

for line in $FS_PP
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
level2_ftrack $line
done

sleep 5

for line in $FS_P_DS 
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
level2_ftrack $line
done

sleep 5

for line in $FS_PP_CTS 
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
level2_ftrack $line
done

echo -e "\e[35m *******Succesfully completed on $(date) ***********\n \e[0m"
exit 0

