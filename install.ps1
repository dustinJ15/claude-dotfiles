# Link ~/.claude/skills to this repo's skills/ via an NTFS junction (no admin needed).
$ErrorActionPreference = "Stop"

$claudeDir = Join-Path $HOME ".claude"
$link = Join-Path $claudeDir "skills"
$target = Join-Path $PSScriptRoot "skills"

New-Item -ItemType Directory -Force $claudeDir | Out-Null

if (Test-Path $link) {
    throw "$link already exists. Move it aside (or merge its contents into $target) first."
}

New-Item -ItemType Junction -Path $link -Target $target | Out-Null
Write-Host "Linked $link -> $target"
