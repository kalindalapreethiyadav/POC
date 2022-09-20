

#!/bin/bash

exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
Tracked_filepath=$(cat output.txt)
fsize="+200c"
file_per=1

echo -e "\e[32m *******Script started on $(date) ***********\n \e[0m" 

pre_fcheck()
 {
#Tracking & identify the pre-defined test files that matches the sufix/pre-fix
echo -e "\e[32m Test files in $1:\n \e[0m"
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*TEST*FILE*" -o -name "*test*file*" -o -name '*ONETIME*' -o -name '*TEST*' -o -name '*DUMMY*' \) -exec ls -lt {} \; | awk '{print $NF}'
echo -e "\e[34m-------------------------------------------\e[0m"
 
#identifying the 60 days old-dates files 
echo -e "Files older than 60 days in $1 :\n"
find $1 -type f -mtime +60 -ls | awk '{print $(8)" "$(9) "\t" $(NF-4) "\t" $NF}'
echo -e "\e[34m-------------------------------------------\e[0m"

#Tracking files - If file size is > $fsize (specfic size) and if older than 15 days 
echo -e "Files size > $fsize & modified 15 days prior in $1 : \n"
find $1 -type f -mtime +15 -size $fsize -ls | awk '{print $(NF-4)" "$NF}'
echo -e "\e[34m-------------------------------------------\e[0m"
}


level2_ftrack()
{
echo -e "\e[32m Tracking files > $file_per% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1)
cd $line
find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}' 2>/dev/null 1>output.txt
for line in $Tracked_filepath
        do
        if [ -f "$line" ]; then
           # echo -e "$line is a file";
            used_fsize=$(ls -lrt $line | awk '{print $5F}')
            #echo $total_size $used_fsize 
            fpercent=$((100*$used_fsize/$total_size ))
                if [ $fpercent -ge $file_per ] ; then
                echo "Total_SIZE = $total_size Used_SIZE = $used_fsize  File_Details = $line  Used_percent = $fpercent"
                else
                echo " " > /dev/null
                fi
        else
            echo " " > /dev/null
        fi
        done  
    }

#Reading each filesystem path in filepath file and calling the functions with arguments
for line in $filepath 
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
pre_fcheck "$line"
level2_ftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date) ***********\n \e[0m"
exit 0

