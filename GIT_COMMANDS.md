# Git Commands Reference

Use these commands from the project folder:

```powershell
cd "C:\Users\VENKAT\Documents\HCM Technical\30-Days-Of-Python-master"
```

## First-time setup

Configure your Git identity once:

```powershell
git config --global user.name "pvrmscpaas-ai"
git config --global user.email "pvrmscpaas-ai@users.noreply.github.com"
```

Check your configuration:

```powershell
git config --global --list
```

## Create or inspect a repository

```powershell
git init                 # Initialize a new repository
git status               # Show changed and untracked files
git log --oneline        # Show commit history
git remote -v            # Show connected remote repositories
```

## Connect to GitHub

```powershell
git remote add origin https://github.com/pvrmscpaas-ai/Python-Learning.git
git branch -M main
git push -u origin main
```

## Save changes

```powershell
git add .                 # Stage all changes
git add path/to/file.py   # Stage one file
git diff                  # View unstaged changes
git diff --staged         # View staged changes
git commit -m "Describe the change"
git push                  # Upload commits to GitHub
```

## Get the latest changes

```powershell
git pull origin main
```

The usual daily workflow is:

```powershell
git pull
git status
git add .
git commit -m "Describe the change"
git push
```

## Branches

```powershell
git branch                  # List local branches
git branch -a               # List local and remote branches
git switch -c feature-name  # Create and switch to a branch
git switch main             # Switch branches
git push -u origin feature-name
```

## Undo and recovery

```powershell
git restore path/to/file.py          # Discard unstaged changes in a file
git restore --staged path/to/file.py # Unstage a file
git commit --amend                   # Edit the latest commit
git stash                            # Temporarily save uncommitted changes
git stash pop                        # Restore stashed changes
```

Be careful with commands that discard changes, such as `git restore`.

## Common checks

```powershell
git status
git log --oneline --decorate --graph --all
git remote get-url origin
git branch --show-current
```

## GitHub repository

Project repository: <https://github.com/pvrmscpaas-ai/Python-Learning>
