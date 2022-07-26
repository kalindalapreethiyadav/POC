

#!/bin/bash
filepath=$(cat filepath.txt)

dummy_fcheck()
{
echo -e "\e[32m Pre-defined sufix/prefix based test files in $line:\n \e[0m"
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*Test*file*" \) -exec ls -lt {} \;
echo "-----------------------------"
}

old_dated_file()
{
echo -e "\e[32m Old dated files >60days in $line filesystem:\n \e[0m"
find $1 -mtime +60 -ls
echo "-----------------------------"
}

highused_files()
{
echo -e "\e[34m Top 5 directory  & usage files & listing <15days created files in $Filesystem_Path:\n \e[0m"

find S1 -type f -exec du -sk {} + | sort -rn | head -5 > dufiles.txt
find . -type d -exec du -sk {} + | sort -rn | head -5 > dudir.txt

for i in $dufiles.txt
do
dir_func "$i"
done

for i in $dudir.txt
do
file_func()
done

}


dir_func()
{
echo -e "I am in $1 director\n"
}

file_func()
{
echo -e "found file $1 "\n"
}


for line in $filepath
do
#cd $line

#calling functions
dummy_fcheck "$line"
old_dated_file "$line"
highused_files "$line"

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"

done


exit 0

