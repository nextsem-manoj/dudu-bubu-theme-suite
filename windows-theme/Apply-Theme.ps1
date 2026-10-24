# 1-Click Installer for Bubu & Dudu Kawaii Windows Theme
$themeDir = "$env:LOCALAPPDATA\Microsoft\Windows\Themes\BubuAndDudu"
New-Item -ItemType Directory -Force -Path "$themeDir\wallpapers" | Out-Null

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Copy-Item "$scriptDir\wallpapers\*" "$themeDir\wallpapers\" -Force

# Windows 10/11 requires UTF-16LE (Unicode) encoding and explicit paths
$themePath = "$themeDir\BubuAndDudu.theme"
$themeContent = @"
; Bubu & Dudu Kawaii Windows Theme
[Theme]
DisplayName=Bubu & Dudu Kawaii Theme
SetLogonBackground=0

[Control Panel\Desktop]
Wallpaper=$themeDir\wallpapers\01_bubu_dudu_picnic.jpg
TileWallpaper=0
WallpaperStyle=10
Pattern=

[Slideshow]
Interval=1800000
Shuffle=1
ImagesRootPath=$themeDir\wallpapers
Item0Path=$themeDir\wallpapers\01_bubu_dudu_picnic.jpg
Item1Path=$themeDir\wallpapers\02_bubu_dudu_movie_night.jpg
Item2Path=$themeDir\wallpapers\03_bubu_dudu_sticker_collage.jpg
Item3Path=$themeDir\wallpapers\04_bubu_dudu_strawberries.jpg
Item4Path=$themeDir\wallpapers\05_bubu_dudu_gaming.jpg

[VisualStyles]
Path=%ResourceDir%\Themes\Aero\Aero.msstyles
ColorStyle=NormalColor
Size=NormalSize
AutoColorization=0
ColorizationColor=0XC4FF7E94
SystemMode=Light
AppMode=Light

[MasterThemeSelector]
MTSM=RJSPBS
"@

[System.IO.File]::WriteAllText($themePath, $themeContent, [System.Text.Encoding]::Unicode)
[System.IO.File]::WriteAllText("$scriptDir\BubuAndDudu.theme", $themeContent, [System.Text.Encoding]::Unicode)

# Set wallpaper immediately via Win32 API
$wallpaperPath = "$themeDir\wallpapers\01_bubu_dudu_picnic.jpg"
$code = @"
using System;
using System.Runtime.InteropServices;
public class WallpaperSetter {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue
[WallpaperSetter]::SystemParametersInfo(20, 0, $wallpaperPath, 3)

# Activate theme via shell
Start-Process -FilePath $themePath

Write-Host "✨ Bubu & Dudu Kawaii Theme applied successfully to your Windows PC! ✨" -ForegroundColor Magenta
Write-Host "Slideshow and pastel colors are now active." -ForegroundColor Green
