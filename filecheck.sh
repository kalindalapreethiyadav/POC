

#!/bin/bash

filepaths=$(cat filepath.txt)
fsize="+2000000000c"

pre_fcheck()
 {
echo -e "\e[32mPre-defined test files in $1:\n \e[0m" 
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*TEST*FILE*" -o -name "*test*file*" -o -name '*ONETIME*' -o -name '*TEST*' -o -name '*DUMMY*' \) -exec ls -lt {} \; 
echo "********************************************************"
 } >> /home/preek/pre_testfiles.txt


old_dated()
{
echo -e "\nFiles older than 60 days in $1 :\n"
find $1 -type f -mtime +60 -ls | awk '{print $(NF-4)" "$NF}'
echo "********************************************************"
 } >> /home/preek/olddated_files.txt

highused_files()
{
echo -e "\nFiles size >2GB & modified 60 days before details in $1 :"
find $1 -type f -mtime +60 -size $fsize -ls | awk '{print $(NF-4)" "$NF}'
echo "********************************************************"
} >> /home/preek/highused_files.txt
 
for line in $filepaths
do
#calling functions
pre_fcheck "$line"
highused_files "$line"
old_dated "$line"
done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

