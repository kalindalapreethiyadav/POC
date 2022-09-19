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
      if [ -f "$1" ]; then
      echo "$1 file"
      fi
      elif [ -d "$1"]; then
      echo "$1 director"
      else
      echo "nothing"
      fi
    }

for line in $filepath
do
level3_dftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date +%F) ***********\n \e[0m"
exit 0

