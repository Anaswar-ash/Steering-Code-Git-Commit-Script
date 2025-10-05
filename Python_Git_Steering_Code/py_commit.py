#!/usr/bin/env python3
import subprocess
import os
import sys

class AIGitCommitter:
    def __init__(self):
        self.check_git_repo()

    def check_git_repo(self):
        """Verify we're in a git repository"""
        result = subprocess.run(['git', 'rev-parse', '--is-inside-work-tree'],
                                capture_output=True, text=True)
        if result.returncode != 0:
            print("❌ Not a git repository")
            sys.exit(1)

    def get_repo_status(self):
        """Get git status and diff for AI analysis"""
        status = subprocess.run(['git', 'status', '--porcelain'],
                                  capture_output=True, text=True).stdout
        diff = subprocess.run(['git', 'diff'],
                              capture_output=True, text=True).stdout
        return status, diff

    def analyze_changes(self, status, diff):
        """AI analysis of changes (mock - replace with actual AI API call)"""
        # This is where you'd call OpenAI, Anthropic, etc.
        # For now, using a simple heuristic

        changed_files = [line[3:] for line in status.strip().split('\n') if line]

        # Simple heuristic for commit type
        if any('test' in f.lower() for f in changed_files):
            commit_type = "test"
        elif any('doc' in f.lower() for f in changed_files):
            commit_type = "docs"
        else:
            commit_type = "chore"

        return {
            'stage': '.',  # Stage all changes
            'commit': f"{commit_type}: update {len(changed_files)} files"
        }

    def execute_commit(self, decisions):
        """Execute the git commands"""
        print(f"📦 Staging files: {decisions['stage']}")
        subprocess.run(['git', 'add', decisions['stage']], check=True)

        print(f"💾 Committing: {decisions['commit']}")
        subprocess.run(['git', 'commit', '-m', decisions['commit']], check=True)

    def run(self):
        """Main workflow"""
        print("🤖 AI Git Assistant Starting...")

        status, diff = self.get_repo_status()
        if not status.strip():
            print("✅ No changes to commit")
            return

        decisions = self.analyze_changes(status, diff)
        self.execute_commit(decisions)
        print("✅ Commit created successfully!")

if __name__ == "__main__":
    committer = AIGitCommitter()
    committer.run()
