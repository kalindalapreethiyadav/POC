1)dummy:-
find . -type  f \( -name '*test*' -o -name "*onetime*" -o -name "*dummy*" -o -name "*Test*file*" \) -exec ls -lt {} \;
2) >60 files in director:-
find . -type f -mtime +1 -exec $(ls -lrt) {} \;
3)top 5 files :-
find . -type f -exec ls -al {} \; | sort -nr -k5 | head -n 5