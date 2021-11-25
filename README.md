# Linuxize Your School PC
## Preface
This guide will require you to use Powershell. I'll guide you through the way though so don't worry if you don't have experience or aren't "Tech literate". Also as I've stated in the license just don't be stupid and don't lead the school to take action. You can follow these steps by simply opening up powershell (you can just search for powershell in windows search) and copy and pasting the commands below.
## General Steps
### Install and configure scoop
1. Change into your home directory
```powershell
Set-Location $env:userprofile
```
2. Set the execution policy in Powershell to allow you to run scripts regardless of if they were signed
```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```
3. Run my modified installer
```powershell
iwr -useb https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/scoop-install.ps1 | iex
```
4. Install my mpv config
```powershell
mkdir $env:userprofile\scoop\persist\mpv\portable_config
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/mpv.conf" -Outfile "$env:userprofile\scoop\persist\mpv\portable_config\mpv.conf"
```
### Configure Windows Terminal
1. Download my powershell startup script (p.ps1) to your home directory
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/p.ps1" -Outfile "$env:userprofile\scoop\persist\mpv\portable_config\mpv.conf
```
2. Download and install FiraCode to your user fonts by downloading the ttf file and starting it through powershell. You will see a button that says 'install'. Click that button to install the font to your user fonts.
```powershell
Invoke-WebRequest "https://github.com/mrf-dot/linuxize-school-pc/blob/main/FiraCode-NF.ttf?raw=true" -OutFile $env:userprofile/Downloads/FiraCode-NF.ttf
Start-Process $env:userprofile\Downloads\FiraCode-NF.ttf
```
3. Download my windows terminal profile to the windows-terminal profile directory
```powershell
mkdir "$env:LocalAppData\Microsoft\Windows Terminal"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/settings.json" -OutFile "$env:LocalAppData\Microsoft\Windows Terminal\settings.json"  
```
### Configure Neovim
1. Install vim-plug to use vim plugins like code completion and bracket matching
```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```
2. Download my vim config (init.vim) to your ~/AppData/Local/nvim folder
```powershell
mkdir $env:LocalAppData/nvim
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/init.vim" -Outfile "$env:localappdata\nvim\init.vim"
```
### Final preparations
1. Enter the current version of powershell installed with scoop (You may get profile restriction errors. This is normal).
```powershell
pwsh
```
2. Allow for the execution of scripts such as the powershell startup script.
```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```
3. Open windows terminal (You should pin it to the taskbar so that you can find it easily later).
```powershell
wt
```
## Afterword
Now your system is configured to be "advanced". Learn how to use [neovim](https://neovim.io/doc/user/) and [scoop](https://scoop.sh/) by reading their docs.
