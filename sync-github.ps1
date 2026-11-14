<#
.SYNOPSIS
    Safely sync the current VS Code work folder with its GitHub origin/main branch.

.DESCRIPTION
    The repository name is detected from the current work-folder name. The script
    uses the existing Git origin, commits local changes, rebases on origin/main,
    and pushes to main. It never deletes or force-pushes files.

.EXAMPLE
    .\sync-github.ps1

.EXAMPLE
    .\sync-github.ps1 -Message "Complete date and time lesson"
#>

[CmdletBinding()]
param(
    [string]$Message = "Backup $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))"
)

$ErrorActionPreference = "Stop"
$branch = "main"
$repoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$folderName = Split-Path -Leaf $repoPath

function Invoke-Git {
    param([Parameter(Mandatory)][string[]]$Arguments)

    & git -c "safe.directory=$repoPath" -C $repoPath @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Git command failed: git $($Arguments -join ' ')"
    }
}

if (-not (Test-Path (Join-Path $repoPath ".git"))) {
    throw "No Git repository was found in '$repoPath'. Run 'git init' first."
}

$originUrl = (& git -c "safe.directory=$repoPath" -C $repoPath remote get-url origin 2>$null)
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($originUrl)) {
    throw "No 'origin' remote is configured. Add the GitHub repository with 'git remote add origin <url>'."
}

Write-Host "Work folder : $folderName"
Write-Host "GitHub remote: $originUrl"

$currentBranch = (& git -c "safe.directory=$repoPath" -C $repoPath branch --show-current).Trim()
if ($currentBranch -ne $branch) {
    Write-Host "Switching from '$currentBranch' to '$branch'..."
    Invoke-Git @("switch", "-C", $branch)
}

$status = @( & git -c "safe.directory=$repoPath" -C $repoPath status --porcelain )
if ($status.Count -gt 0) {
    Write-Host "Staging local changes..."
    Invoke-Git @("add", "--all")

    $stagedChanges = @( & git -c "safe.directory=$repoPath" -C $repoPath diff --cached --name-only )
    if ($stagedChanges.Count -gt 0) {
        Write-Host "Creating commit: $Message"
        Invoke-Git @("commit", "-m", $Message)
    }
}
else {
    Write-Host "No local changes to commit."
}

Write-Host "Pulling latest changes from origin/$branch..."
& git -c "safe.directory=$repoPath" -C $repoPath pull --rebase origin $branch
if ($LASTEXITCODE -ne 0) {
    throw "Pull failed. Resolve conflicts, then run this script again."
}

Write-Host "Pushing $folderName to origin/$branch..."
Invoke-Git @("push", "-u", "origin", $branch)

Write-Host "Sync completed successfully."
