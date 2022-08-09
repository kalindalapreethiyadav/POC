

#!/bin/bash

filepath=$(cat filepath.txt)
fsize="+200c"

pre_fcheck()
 {
echo -e "\e[32mPre-defined test files in $1:\n \e[0m"
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*TEST*FILE*" -o -name "*test*file*" -o -name '*ONETIME*' -o -name '*TEST*' -o -name '*DUMMY*' \) -exec ls -lt {} \; | awk '{print $NF}'
echo "********************************************************"
 } >> /home/preek/pre_definedfiles.txt


old_dated()
{
echo -e "\nFiles older than 60 days in $1 :\n"
find $1 -type f -mtime +60 -ls | awk '{print $(8)" "$(9) "\t" $(NF-4) "\t" $NF}'
echo "********************************************************"
 } >> /home/preek/olddated_files.txt

highused_files()
{
echo -e "\nFiles size >2GB & modified 60 days before details in $1 :"
find $1 -type f -mtime +60 -size $fsize -ls | awk '{print $(NF-4)" "$NF}'
echo "********************************************************"
} >> /home/preek/highused_files.txt

for line in $filepath
do
#calling functions
pre_fcheck "$line" >> /home/preek/ftrack.log
highused_files "$line" >> /home/preek/ftrack.log
old_dated "$line" >>/home/preek/ftrack.log
done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

