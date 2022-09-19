#!/bin/bash
#exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
#fsize="+200c"
file_per=1
dir_per=1
echo -e "\e[32m *******Script started on $(date +'%m/%d/%Y') ***********\n \e[0m" 
## echo the date at start

level3_dftrack()
{
echo -e "\e[32m Tracking directries > $dir_per% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1)
cd $1
for line in $(find . -path '*/\.*' -prune -o -type d -exec du -sk {} + | sort -rn | head -5 | awk '{print $NF}')
        {
           echo "$line"
        }   
    }

for line in $filepath
do
level3_dftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date +%F) ***********\n \e[0m"
exit 0

