# Bubu & Dudu Kawaii Windows Theme Installer
$themeDest = "$env:LOCALAPPDATA\Microsoft\Windows\Themes\BubuAndDudu"
New-Item -ItemType Directory -Force -Path "$themeDest\wallpapers" | Out-Null

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Copy wallpapers and theme file
Copy-Item "$scriptDir\wallpapers\*" "$themeDest\wallpapers\" -Force
Copy-Item "$scriptDir\BubuAndDudu.theme" "$themeDest\BubuAndDudu.theme" -Force

# Launch the official .deskthemepack so Windows associates and saves the theme
$packPath = "$scriptDir\BubuAndDudu.deskthemepack"
if (Test-Path $packPath) {
    Start-Process -FilePath $packPath
}

# Set wallpaper immediately via Win32 API
$wallpaperPath = "$themeDest\wallpapers\01_bubu_dudu_picnic.jpg"
$code = @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
[Wallpaper]::SystemParametersInfo(20, 0, $wallpaperPath, 3)

Write-Host "✨ Bubu & Dudu Theme has been successfully applied to your Windows PC! ✨" -ForegroundColor Magenta
Write-Host "Wallpapers and accent colors are now active." -ForegroundColor Green
