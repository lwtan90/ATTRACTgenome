###########################################################
# This script serves as:
# 1. a record for the source of variants that has been added to target.setid
# 2. to create target.setid 
# Note: I encourage this script to be created for each set of burden-test.
# Therefore, each folder should have a unique version of listvariants.sh.
#########################################################


### more than 10000 files can be appended. Modify accordingly
### DO NOT MODIFY the file name of target.setid
cat ../sift.setid ../polyphen.setid > target.setid
