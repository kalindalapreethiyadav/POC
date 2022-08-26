
#!/bin/bash

exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
#fsize="+200c"

level2_ftrack()
{
total_size=$(df $line | awk '{print $2}')
echo $total_size
cd $1
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
        {
        echo $line
        if [ -f "$line" ]; then
         echo $line
        else
            echo " " > /dev/null
        fi
        }   
        }

for line in $filepath
do
level2_ftrack $line
done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

