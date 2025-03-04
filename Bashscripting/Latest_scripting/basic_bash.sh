#!/bin/bash  

# “#!” followed by the path to the interpreter
#For instance, ‘#!/bin/bash’ indicates that the script should be run using bash shell

#Debug?
 # ‘-x’ option when running the script, which prints each command to stdout before execution, 
 #‘set -e’, which causes the script to exit immediately if any command exits with a non-zero status, useful for catching errors early.

set -e
trap "echo 'An error occurred'; exit 1" ERR

# Rest of the script...
