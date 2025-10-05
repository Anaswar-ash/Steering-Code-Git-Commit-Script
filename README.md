# Steering-Code-Git-Commit-Script
Steering Code: Git Commit Script to Automate Git.
Author: Ash.
Git Commit and Push Folder Script
A robust Bash shell script to automate the process of initializing a local directory as a Git repository, connecting it to a remote, and pushing all of its contents with a single command.

This script is designed to streamline the workflow of creating a new project and getting it onto a remote host like GitHub, GitLab, or Bitbucket without having to manually run multiple git commands.

Prerequisites
Before using this script, you must have Git installed on your system and accessible in your system's PATH.

You can check if Git is installed by running:

git --version

Installation
Save the Script:
Save the code from the Canvas into a file named git-commit-folder.sh.

Make it Executable:
Open your terminal, navigate to the directory where you saved the file, and run the following command to grant it execute permissions:

chmod +x git-commit-folder.sh

Usage
Run the script from the command line within the folder you want to commit and push.

Syntax
./git-commit-folder.sh <repository_url> ["commit message"]

Arguments
<repository_url> (Required): The full HTTPS or SSH URL of the remote Git repository.

["commit message"] (Optional): A string for the commit message. If you don't provide one, the script will use "Initial commit-ment" as the default.

Examples
1. Pushing with a Custom Commit Message:

./git-commit-folder.sh "[https://github.com/your-username/your-repo.git](https://github.com/your-username/your-repo.git)" "Add initial project files and configuration"

2. Pushing with the Default Commit Message:

./git-commit-folder.sh "[https://github.com/your-username/your-repo.git](https://github.com/your-username/your-repo.git)"

Features
Automated Initialization: Automatically runs git init if the directory is not already a Git repository.

Smart Remote Handling:

Adds the remote URL if it doesn't exist.

Updates the remote URL if it's different from the one provided.

Does nothing if the remote is already correctly configured.

User-Friendly Feedback: Provides clear, color-coded output for each step of the process.

Robust Error Handling: The script will stop immediately and report an error if any command fails.

Default Main Branch: Initializes new repositories with main as the default branch name.

Clean Commit Check: Avoids creating empty commits by checking if there are any staged changes.

How It Works
The script performs the following sequence of actions:

Checks if git is installed.

Validates that a repository URL was provided.

Initializes a Git repository if one doesn't exist.

Configures the remote origin with the provided URL.

Stages all files (git add .).

Commits the staged files with the provided or default message.

Pushes the current branch to the remote origin, setting it as the upstream branch for future pushes.
