#-------------------------------------------------------------------------------------------
# Author: Joey Smith
# Date: 2025-06-25
# Description: This script deletes all local branches in a Git repository except for the 'master' branch.
#-------------------------------------------------------------------------------------------

# I always want to keep my master branch local.
# Set the name of your master/main branch here.
$masterBranchName = "master"

# Delete all local branches except for the master branch.
git branch --format "%(refname:short)" | ForEach-Object { if(!$_.equals("master")){git branch -D $_}}
