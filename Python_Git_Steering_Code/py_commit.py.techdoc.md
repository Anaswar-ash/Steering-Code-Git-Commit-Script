# Technical Documentation for `py_commit.py`

## 1. Introduction

This Python script, `py_commit.py`, is an AI-assisted Git committer. It analyzes the changes in a Git repository and generates a commit message based on a simple heuristic. This script is a template that can be extended to use a real AI API for more sophisticated commit message generation.

## 2. Prerequisites

- **Python 3:** The script is written in Python 3.
- **Git:** The script requires Git to be installed and accessible from the command line.

## 3. Class: `AIGitCommitter`

The main logic is encapsulated within the `AIGitCommitter` class.

### 3.1. `__init__(self)`

The constructor of the class calls the `check_git_repo()` method to ensure that the script is being run inside a Git repository.

### 3.2. `check_git_repo(self)`

This method verifies that the current directory is a Git repository by running `git rev-parse --is-inside-work-tree`. If it's not a Git repository, it prints an error message and exits.

### 3.3. `get_repo_status(self)`

This method retrieves the status of the Git repository. It runs `git status --porcelain` to get a concise summary of the changes and `git diff` to get the actual changes. It returns the status and the diff as strings.

### 3.4. `analyze_changes(self, status, diff)`

This method contains the logic for analyzing the changes and generating a commit message.

**Note:** This is a mock implementation. To make it a true AI committer, you would replace the heuristic with a call to an AI service (like OpenAI's GPT, Anthropic's Claude, etc.), passing the `status` and `diff` as context.

The current heuristic works as follows:
1. It gets the list of changed files from the `status`.
2. It determines a `commit_type` based on the file names:
    - If any file name contains "test", the type is "test".
    - If any file name contains "doc", the type is "docs".
    - Otherwise, the type is "chore".
3. It returns a dictionary with the decision to stage all files (`.`) and the generated commit message (e.g., "chore: update 3 files").

### 3.5. `execute_commit(self, decisions)`

This method executes the Git commands based on the decisions from `analyze_changes`.
1. It stages the files using `git add`.
2. It commits the changes with the generated message using `git commit -m`.

### 3.6. `run(self)`

This is the main workflow method:
1. It prints a starting message.
2. It gets the repository status. If there are no changes, it prints a message and exits.
3. It calls `analyze_changes` to get the commit decisions.
4. It calls `execute_commit` to perform the staging and commit.
5. It prints a success message.

## 4. How to Use

1. Place the `py_commit.py` script in your project's root directory (or any directory within a Git repository).
2. Make some changes to your files.
3. Run the script from your terminal:
   ```bash
   python py_commit.py
   ```
The script will then automatically stage your changes and create a commit with a generated message.

## 5. Extending for Real AI

To use a real AI model, you would modify the `analyze_changes` method. Here's a conceptual example using a hypothetical `call_ai_api` function:

```python
def analyze_changes(self, status, diff):
    prompt = f"""
    Analyze the following git status and diff, and generate a conventional commit message.

    Status:
    {status}

    Diff:
    {diff}
    """
    commit_message = call_ai_api(prompt)  # Replace with your actual API call
    return {
        'stage': '.',
        'commit': commit_message
    }
```
