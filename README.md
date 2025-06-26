# PowerShellScripts

### Git Scripts

> [!CAUTION]
> Before using the clean up scripts, be sure to understand the different between `git branch -D` and `git branch -d`.

- [Clean Up Local Branches But Master](https://github.com/Joey-Smith/PowerShellScripts/blob/master/GitScripts/CleanupLocalBranchesButMaster.ps1) & [Clean Up Local Branches Without Remotes](https://github.com/Joey-Smith/PowerShellScripts/blob/master/GitScripts/CleanupLocalBranchesWithoutRemotes.ps1)
  - I got tired of looking at a wall of local branches I had merged and deleted. I got even more tired of deleting them one by one in Visual Studio. If that sounds like you, try these scripts.
  - The first script force deletes all local branches that aren't named whatever you set the $masterBranchName variable to. This works for me after a PR because I typically don't maintain multiple workstreams in a single repository.
  - The second script force deletes all local branches that have had their remote/origin branch deleted or never had one to begin with. $${\color{red}Warning}$$: This will delete local branches that have never been committed. See the script's comments for details on how to avoid this.
