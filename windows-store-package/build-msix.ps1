# Build MSIX / APPX Package for Microsoft Store
$packageDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$outputMsix = "$packageDir\Nextsem.BubuandDuduThemePack.msix"

# Search for MakeAppx in common Windows SDK directories
$makeAppxPaths = @(
    "C:\Program Files (x86)\Windows Kits\10\bin\10.0.*\x64\makeappx.exe",
    "C:\Program Files (x86)\Windows Kits\10\bin\x64\makeappx.exe",
    "C:\Program Files\Windows Kits\10\bin\10.0.*\x64\makeappx.exe"
)

$makeAppx = $null
foreach ($p in $makeAppxPaths) {
    $found = Resolve-Path $p -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) { $makeAppx = $found.Path; break }
}

if ($makeAppx) {
    Write-Host "Found MakeAppx at: $makeAppx" -ForegroundColor Green
    & $makeAppx pack /d "$packageDir" /p "$outputMsix" /o
    Write-Host "✨ Successfully compiled MSIX package: $outputMsix" -ForegroundColor Magenta
} else {
    Write-Host "Windows SDK MakeAppx not found in PATH." -ForegroundColor Yellow
    Write-Host "To package this folder into an MSIX file:" -ForegroundColor Cyan
    Write-Host "1. Install the free 'MSIX Packaging Tool' from the Microsoft Store." -ForegroundColor White
    Write-Host "2. Open the tool, choose 'Package Editor' or 'Create Package from folder'." -ForegroundColor White
    Write-Host "3. Point to this folder: $packageDir" -ForegroundColor White
    Write-Host "4. It will validate the AppxManifest.xml and generate your .msix file!" -ForegroundColor Green
}
