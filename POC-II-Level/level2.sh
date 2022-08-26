
#!/bin/bash

exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
fsize="+200c"

file_track()
 {
echo -e "\e[32m Test files in $1:\n \e[0m"
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*TEST*FILE*" -o -name "*test*file*" -o -name '*ONETIME*' -o -name '*TEST*' -o -name '*DUMMY*' \) -exec ls -lt {} \; | awk '{print $NF}'
echo -e "\e[34m-------------------------------------------\e[0m"

echo -e "\e[32m Files older than 60 days in $1 :\n \e[0m"
find $1 -type f -mtime +60 -ls | awk '{print $(8)" "$(9) "\t" $(NF-4) "\t" $NF}'
echo -e "\e[34m-------------------------------------------\e[0m"

echo -e "\e[32m Files size > $fsize & modified 15 days prior in $1 : \n \e[0m"
find $1 -type f -mtime +15 -size $fsize -ls | awk '{print $(NF-4)" "$NF}'
echo -e "\e[34m-------------------------------------------\e[0m"
 }

High_used_file()
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

director_func()
{
for line in (find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -5)
 
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
 total_size=$(df -g $line | awk '{print $2}')
 echo $total_size
 director_func $line
 done



echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

