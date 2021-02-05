########################################
# This Shell script will initiate a burden test after the target set of SNPs and their genes were decided from
# the annotation
# This means if only Frameshift indels were considered, only variants + genes recorded in frameshift_indel.setid should be included
# See how to form the setid instruction in the README.md
#
# Assuming that you have "target.setid" formed, this script will generate commands to run multiple jobs on aquila. Each job will perform
# Burden test on 1 gene.
#
# Dependencies:
#1. burdentest.r
#2. target.setid
#3. plink files from WGSfiltering step
#4. eigenvalues estimated from WGSfiltering step
#5. burden.sh
#
# Consider adding full path to burden.sh
#########################################


## Form the cmd for burdentest
## target.setid can be formed by using listvariants.sh file found in the bin
## setid file <gene id><variant>
awk '{print "sh /mnt/projects/wlwtan/cardiac_epigenetics/burden.sh "$1}' target.setid | uniq > burden.cwd

## If aquila is still being used, I will split all genes into 50 lines per script, and run
split --lines=50 burden.cwd
ls x* | awk '{print "qsub -pe OpenMP 1 -l h_rt=2:00:00,mem_free=20G -V -cwd "$1}' > run.cwd
sh run.cwd
## Good luck

