#!/bin/bash

<<Intro
*****************************************************************************
Identifying the files in the Filesystem Path by ignoring the Hidden-binary files and Tracking HIGH DISK USED FILES by sorting
Identifying the TOP 10 high disk used files in specified Paths
Intro

#Tracking files >5% based on Total_size of Disk Filesystem
 #Saving entire log in single file
exec 1> file_tracking.log 2>&1 
filepath=$(cat filepath.txt) #Provide the Paths where we need to the Track files
Track_file_percent=5     # Identifing the files > 5%

echo -e "\e[35m *******Script started on $(date)***********\n \e[0m"

level2_ftrack()
{
echo -e "\e[32m Tracking files > $Track_file_percent% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1) #Finding the Total Size of the Path based on disk FS Mount Size
cd $line
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
        do
        if [ -f "$line" ]; then
            used_fsize=$(ls -lrt $line | awk '{print $5F}') 
            fpercent=$((100*$used_fsize/$total_size )) 
                if [ $fpercent -ge $Track_file_percent ] ; then 
                echo "Total_SIZE = $total_size Used_SIZE = $used_fsize Used_percent = $fpercent  File_Details = $line" 
                else
                echo " " > /dev/null # suppress the data
                fi
        else
            echo " " > /dev/null
        fi
        done
    }

#Reading each filesystem path in filepath file
for line in $filepath 
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
level2_ftrack $line #Passing with argument to function
done

echo -e "\e[35m *******Succesfully completed on $(date) ***********\n \e[0m"
exit 0


