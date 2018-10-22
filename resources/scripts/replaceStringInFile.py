#This script replaces a string in a specific file and copies the data to a temp file.
#arg1:Location of source script
#arg2:Location of temp script
#arg3:String to replace with
#arg4:String to be replaced
import sys
import os
import glob
import os
from shutil import copyfile
arg1=sys.argv[1]
arg2=sys.argv[2]
arg3=sys.argv[3]
arg4=sys.argv[4]
oldfile=arg1
newfile=arg2+"temp.py"
# Read in the file
with open(oldfile, 'r') as file :
  filedata = file.read()

# Replace the target string
filedata = filedata.replace(arg4, arg3)
print filedata
# Write the file out again
os.chmod(arg2, 436)
with open(arg2, 'w') as file:
  file.write(filedata)

