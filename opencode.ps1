# opencode.ps1
# Author: Marcel Schliwka
# Creation Date: 11\25\2023

# Description: This PowerShell script, 'opencode.ps1', 
# is a convenient tool for cloning Git repositories and opening them 
# in Visual Studio Code. It takes a single argument, 
# the URL of the Git repository to be cloned. 
# The script first checks if the provided repository URL is valid. 
# It then extracts the GitHub username and repository name from the URL to 
# organize cloned repositories into a structured directory pattern under the 
# user's 'Documents' folder, following the format Documents\repos\username\repositoryName.

if ($args.Count -eq 0) {
    Write-Host "Please provide a link to the repository you like to clone!"
    exit
}

$gitrepolink = $args[0]
$mydocuments = [environment]::GetFolderPath("MyDocuments")

$teile = $gitrepolink -split '/'
$benutzername = $teile[$teile.Length - 2]
$repoName = Split-Path $gitrepolink -Leaf
$repoName = $repoName.TrimEnd('.git')

$savepath = Join-Path $mydocuments "repos\$benutzername\$repoName"

Write-Host "Git Repository Link: $gitrepolink" 

if (-not (Test-Path -Path $savepath)) {
    New-Item -ItemType Directory -Path $savepath -Force
}

try {
    $repoExists = Test-Path -Path $savepath -PathType Container
    $repoNotEmpty = (Get-ChildItem -Path $savepath -Recurse).Count -gt 0

    if ($repoExists -and $repoNotEmpty) {
        $antwort = Read-Host "The respository '$repoName' already exists. Would you like to override it? (yes / no)"
        if ($antwort -eq 'yes') {
            Remove-Item -Recurse -Force $savepath
            git clone $gitrepolink $savepath
        }
    } else {
        git clone $gitrepolink $savepath
    }
    code $savepath
} catch {
    throw "Something went wrong. Please check your repository link!"
}
