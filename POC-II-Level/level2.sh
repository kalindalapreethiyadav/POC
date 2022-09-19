
#!/bin/bash
#exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
tracked_files=$(cat list_files.txt)
#fsize="+200c"
file_per=1
dir_per=10
echo -e "\e[32m *******Script started on $(date) ***********\n \e[0m" 
## echo the date at start
level2_ftrack()
{
echo -e "\e[32m Tracking files > $file_per% in $1:\n \e[0m"

total_size=$(df $line | awk '{print $2}' | tail -1)
cd $line

find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}' 1> ./list_files.txt 2>/dev/null

for line in $tracked_files
        {
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
        }   
    }

for line in $filepath
do
level2_ftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date +%F) ***********\n \e[0m"
exit 0

