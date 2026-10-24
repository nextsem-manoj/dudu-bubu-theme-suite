@echo off
title Push Bubu and Dudu Theme Suite to GitHub
echo ========================================================
echo   Pushing Bubu & Dudu Theme Suite to your GitHub Repo
echo ========================================================
echo.
set /p REPO_URL="Paste your GitHub repository URL (e.g. https://github.com/nextsemacademy-max/dudu-bubu-theme-suite.git): "
if "%REPO_URL%"=="" (
    echo [ERROR] No URL entered. Exiting...
    pause
    exit /b
)

echo.
echo Setting remote origin to %REPO_URL% ...
git remote remove origin 2>nul
git remote add origin %REPO_URL%
git branch -M main

echo.
echo Pushing to GitHub main branch...
git push -u origin main

echo.
echo ========================================================
echo   Done! Check your GitHub repository link.
echo ========================================================
pause
