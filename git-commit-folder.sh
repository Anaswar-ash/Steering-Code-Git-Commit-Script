#!/bin/bash

# A robust script to initialize a local directory as a Git repository,
# connect it to a remote, and push all its contents with a single command.

# --- Color Codes for Output ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Error Handling Function ---
# Exits the script with a specified error message.
# @param {string} message - The error message to display.
error_exit() {
    echo -e "${RED}ERROR: $1${NC}" >&2
    exit 1
}

# --- Main Logic ---
main() {
    # 1. Prerequisites Check
    # Ensure Git is installed on the system.
    if ! command -v git &> /dev/null; then
        error_exit "Git is not installed. Please install Git to use this script."
    fi

    # 2. Argument Validation
    # Assign arguments to variables for clarity.
    REPO_URL=$1
    COMMIT_MESSAGE=$2

    # Check for the required repository URL.
    if [ -z "$REPO_URL" ]; then
        echo -e "${YELLOW}Usage: $0 <repository_url> [\"commit message\"]${NC}"
        error_exit "Repository URL is a required argument."
    fi

    # Provide a default commit message if one isn't supplied.
    if [ -z "$COMMIT_MESSAGE" ]; then
        COMMIT_MESSAGE="Initial commit"
        echo -e "${YELLOW}No commit message provided. Using default: \"$COMMIT_MESSAGE\"${NC}"
    fi

    # 3. Git Repository Initialization
    # Check for an existing .git directory.
    if [ ! -d ".git" ]; then
        echo -e "${YELLOW}Initializing a new Git repository...${NC}"
        git init -b main || error_exit "Failed to initialize Git repository."
    else
        echo -e "${GREEN}Existing Git repository found.${NC}"
    fi

    # 4. Remote Repository Configuration
    # Check if a remote named 'origin' is already configured.
    if git remote -v | grep -q "^origin"; then
        EXISTING_URL=$(git remote get-url origin)
        # If the existing URL is different from the provided one, update it.
        if [ "$EXISTING_URL" != "$REPO_URL" ]; then
            echo -e "${YELLOW}Updating remote 'origin' URL...${NC}"
            git remote set-url origin "$REPO_URL" || error_exit "Failed to update remote URL."
        else
            echo -e "${GREEN}Remote 'origin' is already correctly configured.${NC}"
        fi
    else
        # If no 'origin' remote exists, add it.
        echo -e "${YELLOW}Adding remote 'origin'...${NC}"
        git remote add origin "$REPO_URL" || error_exit "Failed to add remote 'origin'."
    fi

    # 5. Staging and Committing
    echo -e "${YELLOW}Staging all files...${NC}"
    git add . || error_exit "Failed to stage files."

    # Check if there are any changes to commit to avoid an error.
    if git diff-index --quiet HEAD --; then
        echo -e "${GREEN}No changes to commit. Working tree is clean.${NC}"
    else
        echo -e "${YELLOW}Committing changes with message: \"$COMMIT_MESSAGE\"${NC}"
        git commit -m "$COMMIT_MESSAGE" || error_exit "Failed to commit changes."
    fi

    # 6. Branch and Pushing Logic
    # Determine the current active branch name.
    CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
    if [ -z "$CURRENT_BRANCH" ]; then
        error_exit "Could not determine the current branch. Are you in a detached HEAD state?"
    fi

    echo -e "${YELLOW}Pushing to remote repository at $REPO_URL...${NC}"
    # Push the current branch and set it to track the remote branch.
    git push -u origin "$CURRENT_BRANCH" || error_exit "Failed to push to remote repository."

    # --- Success Message ---
    echo -e "\n${GREEN}✅ Successfully pushed all files to $REPO_URL${NC}"
}

# Execute the main function with all script arguments.
main "$@"
