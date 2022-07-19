#/usr/bin/bsh/

set -e #if any error then exit teh script
echo -e "\e[35m Filesystem tracking files growth\e[0m"

Filesystem_Path="/home/centos/POC/"

dummy_fcheck()
{
echo "Tracking the dummy files in $Filesystem_Path:"
cd $Filesystem_Path
find . -type  f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*Test*file*" \) -exec ls -lt {} \; &>> $Filesystem_Path/fs_log.txt
}

old_dated_file()
{
echo "Tracking the >60days old dated files in $Filesystem_Path:"
cd $Filesystem_Path
find . -type f -mtime +1 -exec $(ls -lrt) {} \;
}

highused_files()
{
echo "Finding out Top 5 High space usage files & listing <15days created files in $Filesystem_Path:"
echo "checking test 1:"
find . -type f -exec ls -al {} \; | sort -nr -k5 | head -n 5
echo "checking test 2:"
find . -type f -exec ls -s {} \; | sort -nr | awk 'NR==1 { $1=""; sub(/^ /, ""); print }'
}

#calling functions
dummy_fcheck
old_dated_file
highused_files

exit 0;