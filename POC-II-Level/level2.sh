
#!/bin/bash
#exec 1> file_tracking.log 2>&1
filepath=$(cat filepath.txt)
#fsize="+200c"
file_per=1
echo -e "\e[32m *******Script started on $(date +'%m/%d/%Y') ***********\n \e[0m" 
## echo the date at start

level2_ftrack()
{
echo -e "\e[32m Tracking files > $file_per% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1)
cd $line
for line in $(find . -path '*/\.*' -prune -o -type f -exec du -sk {} + | sort -rn | head -10 | awk '{print $NF}')
        {
        if [ -f "$line" ]; then
           #echo -e "$line is a file";
            used_fsize=$(ls -lrt $line | awk '{print $5F}')
            #echo $total_size $used_fsize 
            fpercent=$((100*$used_fsize/$total_size ))
                if [ $fpercent -ge $file_per ] ; then
                echo "Total_SIZE = $total_size Used_SIZE = $used_fsize  File_Details = $line Used_percent = $fpercent"
                else
                echo " " > /dev/null
                fi
        else
            echo " " > /dev/null
        fi
        }   
    }
<<comm
level3_dftrack()
{
cd $1
if (ls -lrt | grep "^d" )
echo -e "\e[32m Tracking directories > $file_per% in $1:\n \e[0m"
total_size=$(df $line | awk '{print $2}' | tail -1)

for line in ($(find . type -d -exec du -sk {} + | sort -rn | head -10 | awk -F ' ' '{print $NF}'))
{
#for line in ($(ls -lrt | grep "^d" | awk -F ' ' '{print $NF}'))
 # {
   used_fsize=$(ls -lrt $line | awk '{print $5F}')
   fpercent=$((100*$used_fsize/$total_size ))
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
level2_ftrack $line
done

echo -e "\e[32m *******Succesfully completed on $(date +%F) ***********\n \e[0m"
exit 0

