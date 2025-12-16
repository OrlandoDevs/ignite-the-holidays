#!/usr/bin/env pwsh

# Exit on error
$ErrorActionPreference = "Stop"

$SCRIPT_PATH = $MyInvocation.MyCommand.Path
$SCRIPT_DIR = Split-Path -Parent $SCRIPT_PATH

# Get the topic from parameter or prompt
$TOPIC = if ($args.Count -gt 0) { $args[0] } else { "" }
if ([string]::IsNullOrWhiteSpace($TOPIC)) {
    $TOPIC = Read-Host "Enter topic name"
}

# Get mode option from parameter or prompt
$MODE = if ($args.Count -gt 1) { $args[1] } else { "" }
if ([string]::IsNullOrWhiteSpace($MODE)) {
    $MODE = Read-Host "Mode (light/dark)"
}

# Get random option from parameter or prompt
$RANDOM_OPT = if ($args.Count -gt 2) { $args[2] } else { "" }
if ([string]::IsNullOrWhiteSpace($RANDOM_OPT)) {
    $RANDOM_OPT = Read-Host "Random order? (yes/no/random)"
}

$SLIDES = if ($args.Count -gt 3) { [int]$args[3] } else { 20 }

# Set background and color based on mode
if ($MODE -eq "dark") {
    $BACKGROUND_IMAGE = "resources/images/ith-black-background.png"
    $HEADING_COLOR = "#fff"
} else {
    $BACKGROUND_IMAGE = "resources/images/ith-background.png"
    $HEADING_COLOR = "#4B4E52"
}

# Create temporary file
$tempFile = New-TemporaryFile

# UTF8 without BOM
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# Build JSON content
$jsonContent = @"
[
    {
      "filename": "$TOPIC.md",
      "attr":
      {
        "data-autoslide": 5000,
        "data-background": "#fffff",
        "data-background-image": "$BACKGROUND_IMAGE"
      }
    },
"@

# Get files from the directory based on random option
if ($RANDOM_OPT -eq "random" -or $RANDOM_OPT -eq "yes") {
    $files = Get-ChildItem -Path "resources/images/$TOPIC" -File | 
             Get-Random -Count $SLIDES
} else {
    $files = Get-ChildItem -Path "resources/images/$TOPIC" -File | 
             Sort-Object Name |
             Select-Object -First $SLIDES
}

# Count actual number of files
$fileCount = ($files | Measure-Object).Count

$i = 1
foreach ($file in $files) {
    $slideFile = "slides/$i.html"
    if (-not (Test-Path $slideFile)) {
        "" | Out-File -FilePath $slideFile -Encoding utf8
    }
    
    $relativePath = $file.FullName.Replace((Get-Location).Path + "\", "").Replace("\", "/")
    
    $jsonContent += "`n    {"
    $jsonContent += "`n        `"filename`": `"${i}.html`","
    $jsonContent += "`n        `"attr`": {"
    $jsonContent += "`n            `"data-background-image`": `"${relativePath}`","
    $jsonContent += "`n            `"data-background-size`": `"contain`""
    $jsonContent += "`n        }"
    
    if ($i -lt $fileCount) {
        $jsonContent += "`n   },"
    } else {
        $jsonContent += "`n   }"
    }
    
    $i++
}

$jsonContent += "`n]"

# Write to temp file with UTF8 no BOM
[System.IO.File]::WriteAllText($tempFile.FullName, $jsonContent, $utf8NoBom)

# Move temp file to destination
Move-Item -Path $tempFile -Destination "slides/list.json" -Force

# Update template with heading color based on mode
$templatePath = "templates/_index.html"
$templateContent = Get-Content $templatePath -Raw
$templateContent = $templateContent -replace 'color:\s*#[0-9a-fA-F]{3,6};', "color: $HEADING_COLOR;"
[System.IO.File]::WriteAllText((Resolve-Path $templatePath).Path, $templateContent, $utf8NoBom)
