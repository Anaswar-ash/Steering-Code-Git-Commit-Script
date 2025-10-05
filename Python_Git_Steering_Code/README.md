AI Git Committer: Automated Commits with Python
This guide explains how to use the py_commit.py script to fully automate your Git commit workflow. The script handles everything from analyzing and staging changes to generating and executing a conventional commit, providing a hands-off solution.

How It Works
The AIGitCommitter script in py_commit.py automates the entire process by performing the following steps:

Verifies Git Repository: Checks to ensure it's running inside a valid Git repository before proceeding.

Analyzes Changes: Gathers git status and git diff to understand the pending changes.

Generates a Commit Decision: A function analyzes the changed files to determine what to stage and what the commit message should be.

Note: The current version uses a simple placeholder heuristic for generating the commit message. The analyze_changes function is the designated place to integrate a real API call to an AI service like the Gemini API for more intelligent message generation.

Executes Commands: Automatically runs git add . and git commit -m "..." with the generated message.

Usage
To use the automated committer, simply run the Python script from the root of your project directory in your terminal.

python3 py_commit.py

The script will start, analyze your repository's state, and create a commit for you if any changes are detected.