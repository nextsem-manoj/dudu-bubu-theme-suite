# 1-Click Installer for Happy Birthday Bubu Windows Theme
$themeDir = "$env:LOCALAPPDATA\Microsoft\Windows\Themes\HappyBirthdayBubu"
New-Item -ItemType Directory -Force -Path "$themeDir\wallpapers" | Out-Null

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Copy-Item "$scriptDir\wallpapers\*" "$themeDir\wallpapers\" -Force

# Windows 10/11 requires UTF-16LE (Unicode) encoding and explicit paths
$themePath = "$themeDir\HappyBirthdayBubu.theme"
$themeContent = @"
; Happy Birthday Bubu Windows Theme (25-Oct)
[Theme]
DisplayName=Happy Birthday Bubu!
SetLogonBackground=0

[Control Panel\Desktop]
Wallpaper=$themeDir\wallpapers\01_happy_birthday_bubu_cake.jpg
TileWallpaper=0
WallpaperStyle=10
Pattern=

[Slideshow]
Interval=1800000
Shuffle=1
ImagesRootPath=$themeDir\wallpapers
Item0Path=$themeDir\wallpapers\01_happy_birthday_bubu_cake.jpg
Item1Path=$themeDir\wallpapers\02_happy_birthday_bubu_gifts.jpg

[VisualStyles]
Path=%ResourceDir%\Themes\Aero\Aero.msstyles
ColorStyle=NormalColor
Size=NormalSize
AutoColorization=0
ColorizationColor=0XC4FF69B4
SystemMode=Light
AppMode=Light

[MasterThemeSelector]
MTSM=RJSPBS
"@

[System.IO.File]::WriteAllText($themePath, $themeContent, [System.Text.Encoding]::Unicode)
[System.IO.File]::WriteAllText("$scriptDir\HappyBirthdayBubu.theme", $themeContent, [System.Text.Encoding]::Unicode)

# Set birthday wallpaper immediately via Win32 API
$wallpaperPath = "$themeDir\wallpapers\01_happy_birthday_bubu_cake.jpg"
$code = @"
using System;
using System.Runtime.InteropServices;
public class BirthdayWallpaperSetter {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
[BirthdayWallpaperSetter]::SystemParametersInfo(20, 0, $wallpaperPath, 3)

# Activate theme via shell
Start-Process -FilePath $themePath

Write-Host "🎂✨ Happy Birthday Bubu! Theme applied successfully! ✨🎂" -ForegroundColor Magenta
Write-Host "Birthday celebration wallpapers and festive pink accent colors are now active!" -ForegroundColor Yellow
