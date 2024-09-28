@echo off
echo [GIT SYNC] Cloning repo from git@github.com:Destice/world.git
git clone git@github.com:Destice/world.git || (
    echo [GIT SYNC] Error during clone
    echo [GIT SYNC] Make sure you have installed and configured git from: https://git-scm.com/download/win
    echo [GIT SYNC] Add your ssh keys to github and contact Destice for repository access rights
    echo [GIT SYNC] retry in 10 seconds... (press Ctrl + C to cancel)
    timeout /t 10 /nobreak > NUL
)