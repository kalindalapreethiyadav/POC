
#!/bin/bash

#exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
#fsize="+200c"

level2_ftrack()
{
total_size=$(df $line | awk '{print $2}' | tail -1)
echo $total_size
cd $line
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
        {
        if [ -f "$line" ]; then
            echo -e "$line is a file";
            used_fsize=$(ls -lrt $line | awk '{print $5F}')
            echo $total_size $used_fsize 
            fpercent=$((100*$used_fsize/$total_size ))
                if [ $fpercent -ge 40 ]
                    echo "$line is > 40%"
                else 
                    echo " " > /dev/null
        else
            echo " " > /dev/null
        fi
        } 
     }
<<comm
level3_dftrack()
{
cd $1
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
{
    if [ -d "$line" ] ; then
        echo "director name : $line";
    else
        if [ -f "$line" ]; then
            echo "$line is a file";
        else
            echo "$line no files or directors found";
            exit 1
        fi
    fi
}
}
comm

for line in $filepath
do
level2_ftrack $line
done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

