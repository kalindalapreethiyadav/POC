
#!/bin/bash

exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
fsize="+200c"

level2_ftrack()
{
cd $1
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}' >> /home/centos/poc/POC/POC-II-Level/filedetails.txt)
        {
        if [ -f "$line" ]; then
            echo "$line is a file";
        else
            echo "$line no files or directors found";
            exit 1
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
 total_size=$(df $line | awk '{print $2}')
 echo $total_size
 level2_ftrack $line
 done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

