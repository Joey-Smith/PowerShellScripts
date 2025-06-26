#-------------------------------------------------------------------------------------------
# Author: Joey Smith
# Date: 2025-06-25
# Description: This script deletes all local branches without a remote in a Git repository.
#-------------------------------------------------------------------------------------------

# All the "atom" names for the --format parameter. After testing, not all actually do anything and some error.
#{ "refname" , FIELD_STR, refname_atom_parser },
#{ "objecttype" },
#{ "objectsize", FIELD_ULONG },
#{ "objectname", FIELD_STR, objectname_atom_parser },
#{ "tree" },
#{ "parent" },
#{ "numparent", FIELD_ULONG },
#{ "object" },
#{ "type" },
#{ "tag" },
#{ "author" },
#{ "authorname" },
#{ "authoremail" },
#{ "authordate", FIELD_TIME },
#{ "committer" },
#{ "committername" },
#{ "committeremail" },
#{ "committerdate", FIELD_TIME },
#{ "tagger" },
#{ "taggername" },
#{ "taggeremail" },
#{ "taggerdate", FIELD_TIME },
#{ "creator" },
#{ "creatordate", FIELD_TIME },
#{ "subject", FIELD_STR, subject_atom_parser },
#{ "body", FIELD_STR, body_atom_parser },
#{ "trailers", FIELD_STR, trailers_atom_parser },
#{ "contents", FIELD_STR, contents_atom_parser },
#{ "upstream", FIELD_STR, remote_ref_atom_parser },
#{ "push", FIELD_STR, remote_ref_atom_parser },
#{ "symref", FIELD_STR, refname_atom_parser },
#{ "flag" },
#{ "HEAD", FIELD_STR, head_atom_parser },
#{ "color", FIELD_STR, color_atom_parser },
#{ "align", FIELD_STR, align_atom_parser }

# I always want to keep my master branch local.
# Set the name of your master/main branch here.
$masterBranchName = "master"

# This checks remote branches and basically puts the 'gone' tag on branches that no longer exist on the remote.
# This is needed for identifying local branches that no longer have a remote.
git remote prune origin

# Switches working branch to something you're likely to keep local and remote
# Prevents errors in case the working branch falls into the two categories to be deleted.
git switch $masterBranchName --quiet

# Gets local branches with deleted remotes.
$output1 = (git branch -vv | Select-String -Pattern ": gone]" | ForEach-Object { $_.Line.Substring(2) } | ForEach-Object { $_.Substring(0,$_.IndexOf(" ")) })

# Gets local branches that never had remotes.
$output2 = (git branch --format "%(refname:short) %(upstream)" | ForEach-Object { if([string]::IsNullOrEmpty(($_ -Split ' ')[1])){$_.Substring(0,$_.Length - 1)}})

# Forcefully deletes these branches. This includes branches that were never merged (i.e. pull requested into master).
# To avoid losing work on new branches switch to lowercase -d instead.
$output1, $output2 | ForEach-Object { git branch -D $_ }