REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f

REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f

taskkill /F /IM explorer.exe

start explorer.exe

powershell.exe -ExecutionPolicy Bypass -File "C:\Users\johan\OneDrive\Johannes\config\windows\light-dark-mode\light-wallpaper.ps1"

