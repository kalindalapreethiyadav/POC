#!/bin/bash
#exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
#fsize="+200c"
dir_per=1
echo -e "\e[32m *******Script started on $(date +'%m/%d/%Y') ***********\n \e[0m" 
## echo the date at start

level3_dftrack()
{
 cd $line
 for FILE in *;
      if [ -f "$line" ]; then
      echo "$line file"
      fi
      elif [ -d "$line"]; then
      echo "$line director"
      else
      echo "nothing"
      fi
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
level3_dftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date +%F) ***********\n \e[0m"
exit 0

and#comment