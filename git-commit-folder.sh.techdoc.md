# Technical Documentation for `git-commit-folder.sh`

## 1. Introduction

This script is a comprehensive Bash utility designed to streamline the process of initializing a local directory as a Git repository, connecting it to a remote repository, and pushing all its contents with a single command. It includes robust error handling and user-friendly feedback.

## 2. Prerequisites

- **Git:** The script requires Git to be installed on the system. It checks for the `git` command and will exit with an error if it's not found.

## 3. Usage

```bash
./git-commit-folder.sh <repository_url> ["commit message"]
```

### Arguments

- **`<repository_url>` (required):** The URL of the remote Git repository.
- **`["commit message"]` (optional):** A message for the commit. If not provided, a default message "Initial commit-ment" will be used.

## 4. Script Breakdown

### 4.1. Color Codes and Error Handling

- **Color Codes:** The script defines color codes for `GREEN`, `RED`, and `YELLOW` to provide colored output for success, error, and warning messages, respectively. `NC` (No Color) resets the terminal color.
- **`error_exit()` function:** This function is used for handling fatal errors. It prints a specified error message in red to `stderr` and exits the script with a status code of 1.

### 4.2. Main Logic (`main` function)

The `main` function encapsulates the core logic of the script.

#### 4.2.1. Prerequisites Check

- It first checks if Git is installed using `command -v git`. If not, it calls `error_exit`.

#### 4.2.2. Argument Validation

- The script expects the remote repository URL and an optional commit message as arguments.
- It checks if the repository URL is provided. If not, it displays the usage information and exits.
- If no commit message is provided, it sets a default message.

#### 4.2.3. Git Repository Initialization

- It checks if a `.git` directory already exists.
- If not, it initializes a new Git repository with the `main` branch using `git init -b main`.
- If a repository already exists, it prints a message indicating that.

#### 4.2.4. Remote Repository Configuration

- It checks if a remote named `origin` is already configured.
- If `origin` exists, it compares the existing URL with the one provided. If they are different, it updates the remote URL using `git remote set-url`.
- If `origin` does not exist, it adds the remote URL using `git remote add origin`.

#### 4.2.5. Staging and Committing

- It stages all files in the current directory using `git add .`.
- It checks for changes to commit using `git diff-index --quiet HEAD --`.
- If there are changes, it commits them with the provided or default commit message.
- If there are no changes, it prints a message indicating that the working tree is clean.

#### 4.2.6. Branch and Pushing Logic

- It determines the current active branch name.
- It pushes the current branch to the `origin` remote and sets it to track the remote branch using `git push -u origin <branch_name>`.

### 4.3. Execution

- The script executes the `main` function, passing all script arguments to it.

## 5. Success Message

Upon successful execution, the script prints a success message indicating that all files have been pushed to the remote repository.
