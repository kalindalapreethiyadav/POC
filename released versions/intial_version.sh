
#!/bin/bash

exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
fsize="+200c"

pre_fcheck()
 {
echo -e "\e[32m Test files in $1:\n \e[0m"
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*TEST*FILE*" -o -name "*test*file*" -o -name '*ONETIME*' -o -name '*TEST*' -o -name '*DUMMY*' \) -exec ls -lt {} \; | awk '{print $NF}'
echo -e "\e[34m-------------------------------------------\e[0m"
 }


old_dated()
{
echo -e "Files older than 60 days in $1 :\n"
find $1 -type f -mtime +60 -ls | awk '{print $(8)" "$(9) "\t" $(NF-4) "\t" $NF}'
echo -e "\e[34m-------------------------------------------\e[0m"
 }

highused_files()
{
echo -e "Files size > $fsize & modified 15 days prior in $1 : \n"
find $1 -type f -mtime +15 -size $fsize -ls | awk '{print $(NF-4)" "$NF}'
echo -e "\e[34m-------------------------------------------\e[0m"
}

for line in $filepath
do
echo -e "\e[36m****************started files tracking on $line******************\e[0m \n"
#calling functions
pre_fcheck "$line"
old_dated "$line"
highused_files "$line"
done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

