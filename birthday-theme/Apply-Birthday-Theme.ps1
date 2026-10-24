# Apply Happy Birthday Bubu Theme
$themeDest = "$env:LOCALAPPDATA\Microsoft\Windows\Themes\HappyBirthdayBubu"
New-Item -ItemType Directory -Force -Path "$themeDest\wallpapers" | Out-Null

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Copy wallpapers and theme file
Copy-Item "$scriptDir\wallpapers\*" "$themeDest\wallpapers\" -Force
Copy-Item "$scriptDir\HappyBirthdayBubu.theme" "$themeDest\HappyBirthdayBubu.theme" -Force

# Launch the official .deskthemepack
$packPath = "$scriptDir\HappyBirthdayBubu.deskthemepack"
if (Test-Path $packPath) {
    Start-Process -FilePath $packPath
}

# Set first birthday wallpaper immediately
$wallpaperPath = "$themeDest\wallpapers\01_happy_birthday_bubu_cake.jpg"
$code = @"
using System;
using System.Runtime.InteropServices;
public class BirthdayWallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
[BirthdayWallpaper]::SystemParametersInfo(20, 0, $wallpaperPath, 3)

Write-Host "🎂✨ Happy Birthday Bubu! Theme has been applied to your Windows PC! ✨🎂" -ForegroundColor Magenta
Write-Host "Birthday wallpapers, slideshow, and festive pink accent colors are now active!" -ForegroundColor Yellow
