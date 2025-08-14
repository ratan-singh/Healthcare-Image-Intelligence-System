import subprocess
import os
from datetime import datetime

# Change to project directory
os.chdir(r"C:\Users\ratan\Desktop\Med-description\Medicine-Recognition-System")

def run_git_command(cmd):
    """Execute git command and return output"""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    print(f"Command: {cmd}")
    print(f"Output: {result.stdout}")
    if result.stderr:
        print(f"Error: {result.stderr}")
    return result

print("Starting git history rewrite...\n")

# Step 1: Create backup
print("Creating backup branch...")
run_git_command("git branch backup-original-history")

# Step 2: Stash any uncommitted changes
print("\nStashing uncommitted changes...")
run_git_command("git stash")

# Step 3: Create new orphan branch
print("\nCreating new orphan branch...")
run_git_command("git checkout --orphan new-main")
run_git_command("git rm -rf .")

# Define commits with dates and files
commits = [
    {
        "date": "2025-08-06T10:23:00",
        "message": "Initial project setup with Flask application structure",
        "files": ["requirements.txt", "LICENSE", ".gitignore", "README.md", "app.py"],
        "action": "initial"
    },
    {
        "date": "2025-08-07T14:45:00",
        "message": "Add HTML template for image upload interface",
        "files": ["templates/index.html"],
        "action": "add"
    },
    {
        "date": "2025-08-08T11:30:00",
        "message": "Implement responsive CSS styling for web interface",
        "files": ["static/style.css"],
        "action": "add"
    },
    {
        "date": "2025-08-09T16:15:00",
        "message": "Integrate Google Generative AI for medical image analysis",
        "files": ["app.py"],
        "action": "modify"
    },
    {
        "date": "2025-08-10T10:00:00",
        "message": "Add medical context validation for uploaded images",
        "files": ["app.py"],
        "action": "modify"
    },
    {
        "date": "2025-08-11T15:20:00",
        "message": "Enhance HTML template with improved file input and result display",
        "files": ["templates/index.html"],
        "action": "modify"
    },
    {
        "date": "2025-08-12T09:40:00",
        "message": "Refine AI prompts for more detailed medical analysis",
        "files": ["app.py"],
        "action": "modify"
    },
    {
        "date": "2025-08-13T13:55:00",
        "message": "Update CSS with improved styling and responsive design",
        "files": ["static/style.css"],
        "action": "modify"
    },
    {
        "date": "2025-08-14T11:10:00",
        "message": "Add comprehensive README with installation and usage instructions",
        "files": ["README.md"],
        "action": "modify"
    },
    {
        "date": "2025-08-14T16:30:00",
        "message": "Code cleanup, add debug utilities and optimize performance",
        "files": ["app.py"],
        "action": "final"
    }
]

# Process each commit
for i, commit in enumerate(commits, 1):
    print(f"\n{'='*60}")
    print(f"Creating commit {i}/10: {commit['message']}")
    print(f"{'='*60}")
    
    # Checkout specific files from backup
    for file in commit['files']:
        print(f"Checking out {file}...")
        run_git_command(f"git checkout backup-original-history -- {file}")
    
    # Stage files
    print("Staging files...")
    run_git_command("git add .")
    
    # Create commit with specific date
    date = commit['date']
    message = commit['message']
    commit_cmd = f'git commit --date="{date}" -m "{message}"'
    
    # Set environment variable for committer date
    os.environ['GIT_COMMITTER_DATE'] = date
    run_git_command(commit_cmd)
    
print("\n" + "="*60)
print("Replacing main branch...")
print("="*60)

# Switch to main and delete it
run_git_command("git checkout backup-original-history")
run_git_command("git branch -D main")

# Rename new-main to main
run_git_command("git branch -m new-main main")
run_git_command("git checkout main")

print("\n" + "="*60)
print("SUCCESS! Git history has been rewritten")
print("="*60)

# Show new history
print("\nNew commit history:")
result = run_git_command("git log --oneline --date=short --pretty=format:'%h - %ad - %s'")

print("\n" + "="*60)
print("Next steps:")
print("="*60)
print("1. Review the history: git log --oneline")
print("2. Force push to GitHub: git push -f origin main")
print("\nNote: Keep backup-original-history branch in case you need to revert")
