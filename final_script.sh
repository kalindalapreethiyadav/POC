
Filesystem_Path="/home/preethi/"
echo "Tracking the dummy files in $Filesystem_Path:"
find . -type  f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*Test*file*" \) -exec ls -lt {} \; &>> /home/preek/logfile.txt
echo "Tracking the >60days old dated files in $Filesystem_Path:"
find . -type f -mtime +1 -exec $(ls -lrt) {} \; &>> /home/preek/logfile.txt
echo "Finding out Top 5 High space usage files & listing <15days created files in $Filesystem_Path:"
find . -type f -exec ls -al {} \; | sort -nr -k5 | head -n 5; &>> /home/preethi/logfile.txt
echo "******sucessful*******"