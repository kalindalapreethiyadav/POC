#!/bin/bash
#exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
#fsize="+200c"
file_per=1
dir_per=5
echo -e "\e[32m *******Script started on $(date +'%m/%d/%Y') ***********\n \e[0m" 
## echo the date at start

level3_dftrack()
{
echo -e "\e[32m Tracking directries > $dir_per% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1)
cd $1
for line in $(find . -path '*/\.*' -prune -o -type d -exec du -sk {} + | sort -rn | head -5 | awk '{print $NF}')
        {
            used_dsize=$(ls -lrt $line | awk '{print $5F}') 
           # dpercent=$((100*$used_dsize/$total_size ))
            echo "Total_SIZE = $total_size Used_SIZE = $used_dsize  directory_Details = $line"
                if [ $dpercent -ge $dir_per ] ; then
                    echo "$line is greater than 5%\n"
                else
                echo "Director $line is not > 5%"
                fi
        }   
    }

for line in $filepath
do
level3_dftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date +%F) ***********\n \e[0m"
exit 0

