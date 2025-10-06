Using the Gemini CLI for Git Commits
Author: Ash.
This guide explains the interactive method for using the gemini_cli_prompt.md file to generate conventional commit messages with the Gemini CLI.

This method is great for when you want AI assistance but still want to review and approve the message before committing. It allows you to reuse a detailed, structured prompt without having to type it out every time.

Interactive Workflow
The process involves two main steps: getting your code changes (the "diff") and then feeding those changes into the Gemini CLI using the prompt file as a template.

Step 1: Stage Files and Get the Diff
Before using the Gemini CLI, you need to tell Git which changes you want to commit.

Stage Your Files: In your regular terminal, navigate to your project directory and stage all the files you want to include in the commit.

git add .

Copy the Staged Diff: Get the summary of staged changes and copy the entire output to your clipboard.

git diff --staged

Step 2: Run the Prompt in Gemini CLI
Now, switch to your Gemini CLI.

Reference the Prompt File: Start your prompt with @ followed by the name of the prompt file. This tells the CLI to load the content of that file as the basis for your prompt.

Paste Your Diff: Immediately after the filename, paste the diff you copied from your terminal.

Your final command in the Gemini CLI will look like this:

> @gemini_cli_prompt.md <PASTE THE OUTPUT FROM 'git diff --staged' HERE>

When you press Enter, the Gemini CLI will combine the instructions from the .md file with your specific code changes and send the complete context to the AI, which will then return a formatted, conventional commit message. You can then copy this message to use in your git commit command.