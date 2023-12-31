# Windows / macOS / Linux Scripts

## Description

This repository includes a collection of helpful scripts for Windows, macOS, and Linux operating systems.

## Contribute

Feel free to contribute by creating a pull request. Please ensure you always update the README.md file to inform others about how to use and install your script.

## Tools

### commit.ps1

This PowerShell script automates the process of running `git add . && git commit -m 'your custom message' && git push`. To use it, add your commit message directly after the script name like this: `commit.ps1 "your message goes here"`, and it will execute the other commands with your custom message.

### opencode.ps1

This PowerShell script clones a Git repository into your user's documents directory and opens it in Microsoft Visual Studio Code. If the repository is already cloned, it prompts the user to either overwrite it or just open it. The script takes a link to the repository as the first parameter, like this: `opencode.ps1 https://github.com/marcel-schliwka/helper_scripts`

## Installation

1. Download the repository as a .zip file by clicking on the green Code button in the top right corner, above the commits. Alternatively, if you have Git CLI installed, use: `git clone https://github.com/marcel-schliwka/helper_scripts` in your terminal.
2. Create a directory on your hard drive to store the scripts. For example, I store my Windows scripts in "C:\my_scripts\".
3. Place the files directly in this folder, like so:
   `C:\my_scripts\commit.ps1` or `C:\my_scripts\opencode.ps1`
4. To access the scripts from anywhere on your PC, include this directory in your PATH Environment Variable.
5. Add to PATH manually or use the addtopath.ps1 script. This script adds the directory in which it is located to PATH. If you followed the example, it should be in the same folder as the other scripts:
   `C:\my_scripts\addtopath.ps1`
   Open your terminal in this directory and run the script: `.\addtopath.ps1`
6. If you encounter an error, ensure the Execution Policy is set to Unrestricted by running: `Set-ExecutionPolicy Unrestricted`, then try the previous command again.
7. Restart your terminal, and you should be able to use the scripts from anywhere, without being in the `C:\my_scripts\` directory.
