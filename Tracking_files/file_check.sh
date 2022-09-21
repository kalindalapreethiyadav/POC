

#!/bin/bash
exec 1> fcheck_log.txt 2>&1 
filepath=$(cat filepath.txt)
filelist=$(cat files_list.txt)
dirlist=$(cat dir_list.txt)
sub_flist=$(cat sub_dudir.txt)

echo -e "***********Script started***************\n"

pre_fcheck()
 {
echo -e "\e[32mPre-defined test files in $line:\n \e[0m" 
find $1 -type f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*Test*file*" -o -name '*TEST*' -o -name '*DUMMY*' \) -exec ls -lt {} \; > /home/preek/pre_testfiles.txt

echo -e "\n**********Files older than 60 days ***********\n"

old_files=$(find $1 -mtime +1 -ls)

if [[ $old_files ]]; then
    echo -e "old dated Files found\n"
	cat old_files
else
    echo -e "No old dated files found\n"
fi
echo "****************************************"
 }

highused_files()
{
	#echo -e "\e[34m Top 5 High disk used directories and files in $Filesystem_Path:\n \e[0m"
	find $1 -type f -exec du -sg {} + | sort -rn | head -5 > dufiles.txt
	find $1 -type d -exec du -sg {} + | sort -rn | head -5 > dudir.txt
}

dir_func()
{
echo -e "\nFinding High disk used files in path : $1 \n"
cd $1
find . -type f -exec du -sk {} + | sort -rn | head -5 > /home/preek/sub_dudir.txt
echo "************************************"
}

<<comm
files_func()
{
   file_len=$(istat "$line" |grep 'Length' | awk '{print $5F}')
   max_len=1800
   if [ -f "$line" && ! -s "$line" ] then
	return
	elif [-f "$line" && -s "$line" && $file_len -ge $max_len ] then
		echo -e "File $line Details : \n"  >> /home/preek/fmail.txt
		istat "$line" >> /home/preek/fmail.txt
		echo -e "-----------------\n" >> /home/preek/fmail.txt
	else
	echo "File "$line" does not exist"
	fi
}
comm


files_func()
{
file_len=$istat "$line" |grep 'Length' | awk '{print $5F}'
max_len=2000000000
    if [[ -f "$line" && -s "$line" && $file_len -ge $max_len && time <15 days ]]
	then
        echo -e "File $line Details : \n"  
        istat "$line"
        echo -e "-----------------\n"
	else
	    echo "File "$line" not > $max_len size\n"
	fi
}

for line in $filepath
do
#calling functions
pre_fcheck "$line"
highused_files "$line"
awk -F ' ' '{print $NF}' dufiles.txt > files_list.txt
awk -F ' ' '{print $NF}' dudir.txt > dir_list.txt
done

for line in $filelist
do
echo -e "\n***checking File size: $line: \n"
files_func "$line"
done

for line in $sub_flist
do
echo -e "\n***checking file size in sub directory $line: \n"
files_func "$line"
done

for line in $dirlist
do
dir_func "$line"
done

echo -e "\e[32m *******Succesfully completed***********\n \e[0m"
exit 0

