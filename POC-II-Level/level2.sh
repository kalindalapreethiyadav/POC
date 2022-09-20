#!/bin/bash

#Tracking files >5% based on Total_size of Disk Filesystem
exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
Track_file_percent=5

echo -e "\e[35m *******Script started on $(date)***********\n \e[0m"

level2_ftrack()
{
echo -e "\e[32m Tracking files > $Track_file_percent% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1)
cd $line
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
        {
        if [ -f "$line" ]; then
           # echo -e "$line is a file";
            used_fsize=$(ls -lrt $line | awk '{print $5F}')
            #echo $total_size $used_fsize
            fpercent=$((100*$used_fsize/$total_size ))
                if [ $fpercent -ge $Track_file_percent ] ; then
                echo "Total_SIZE = $total_size Used_SIZE = $used_fsize Used_percent = $fpercent  File_Details = $line"
                else
                echo " " > /dev/null
                fi
        else
            echo " " > /dev/null
        fi
        }
    }

#Reading each filesystem path in filepath file and calling the functions with arguments
for line in $filepath 
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
level2_ftrack $line
done

echo -e "\e[35m *******Succesfully completed on $(date) ***********\n \e[0m"
exit 0


