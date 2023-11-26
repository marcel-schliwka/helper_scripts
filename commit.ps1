# commit.ps1
# Author: Marcel Schliwka
# Creation Date: 11\25\2023

# Description: This PowerShell script is designed to streamline the Git commit and push process. 
# It combines the three separate commands - git add ., git commit -m "commit message",
# and git push - into a single command, making it more efficient to commit changes
# to a Git repository. The script accepts a commit message as its argument. 
# If no message is provided, it notifies the user and exits without performing any actions. 
# On successful execution, the script stages all changed files in the current directory (git add .),
# commits them with the provided message (git commit), 
# and then pushes the commit to the remote repository (git push). 
# It's a simple yet effective tool for Git users looking to simplify their version control workflow.

if ($args.Count -eq 0) {
    Write-Host "Please provide a commit message."
    exit
}

$commitMessage = $args -join ' '

try {
    git pull
    git add .
    git commit -m $commitMessage
    git push
    Write-Host "Commit and push successful."
} catch {
    Write-Host "An error occurred during commit and push."
}
