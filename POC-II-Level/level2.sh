
#!/bin/bash

exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
fsize="+200c"

level2_track()
{
cd $1
for line in  (find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -5)
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

for line in $filepath
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
#calling functions
file_track "$line"
echo -e "\e[36m****************completed tracking on $line******************\e[0m \n"

echo -e "*************starting Advance level script***********\n"
High_used_file "$line"
echo -e "\e[36m****************completed Advance level one $line******************\e[0m \n"
done

for line in $filepath
do
 total_size=$(df $line | awk '{print $2}')
 echo $total_size
 level2_track $line
 done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

