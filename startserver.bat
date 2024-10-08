@echo off
:PULL
if exist "world" (
    echo [GIT SYNC] Found world file, pulling newest...
    cd world
    git pull || (
        cd ..
        echo [GIT SYNC] ERROR during git pull
        echo [GIT SYNC] Make sure you have installed and configured git from: https://git-scm.com/download/win
        echo [GIT SYNC] You can delete "world" to initiate clone from github
        echo [GIT SYNC] retry in 10 seconds... (press Ctrl + C to cancel)
        timeout /t 10 /nobreak > NUL
        goto:PULL
    )
    cd ..
)

if not exist "world" (
    echo [GIT SYNC] Cloning repo from git@github.com:Destice/world.git
    git clone git@github.com:Destice/world.git || (
        echo [GIT SYNC] Error during clone
        echo [GIT SYNC] Make sure you have installed and configured git from: https://git-scm.com/download/win
        echo [GIT SYNC] Add your ssh keys to github and contact Destice for repository access rights
        echo [GIT SYNC] retry in 10 seconds... (press Ctrl + C to cancel)
        timeout /t 10 /nobreak > NUL
        goto:PULL
    )
)

set FORGE_VERSION=47.2.20
set ATM9_RESTART=false
:: To use a specific Java runtime, set an environment variable named ATM9_JAVA to the full path of java.exe.
:: To disable automatic restarts, set an environment variable named ATM9_RESTART to false.
:: To install the pack without starting the server, set an environment variable named ATM9_INSTALL_ONLY to true.

set INSTALLER="%~dp0forge-1.20.1-%FORGE_VERSION%-installer.jar"
set FORGE_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-%FORGE_VERSION%/forge-1.20.1-%FORGE_VERSION%-installer.jar"

:JAVA
if not defined ATM9_JAVA (
    set ATM9_JAVA=java
)

"%ATM9_JAVA%" -version 1>nul 2>nul || (
   echo Minecraft 1.20.1 requires Java 17 - Java not found
   pause
   exit /b 1
)

:FORGE
setlocal
cd /D "%~dp0"
if not exist "libraries" (
    echo Forge not installed, installing now.
    if not exist %INSTALLER% (
        echo No Forge installer found, downloading from %FORGE_URL%
        bitsadmin.exe /rawreturn /nowrap /transfer forgeinstaller /download /priority FOREGROUND %FORGE_URL% %INSTALLER%
    )
    
    echo Running Forge installer.
    "%ATM9_JAVA%" -jar %INSTALLER% -installServer
)

if not exist "server.properties" (
    (
        echo allow-flight=true
        echo motd=All the Mods 9
        echo max-tick-time=180000
    )> "server.properties"
)

if "%ATM9_INSTALL_ONLY%" == "true" (
    echo INSTALL_ONLY: complete
    goto:EOF
)

for /f tokens^=2-5^ delims^=.-_^" %%j in ('"%ATM9_JAVA%" -fullversion 2^>^&1') do set "jver=%%j"
if not %jver% geq 17  (
    echo Minecraft 1.20.1 requires Java 17 - found Java %jver%
    pause
    exit /b 1
) 

:START
"%ATM9_JAVA%" @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.20.1-%FORGE_VERSION%/win_args.txt nogui

:RETRY_SAVE
echo [GIT SYNC] Pushing local "world" to remote git@github.com:Destice/world.git

cd world || (
    echo [GIT SYNC] ERROR: Can't change dir to world!
    goto:FAIL
)
git add . || (
    cd ..
    echo [GIT SYNC] ERROR: Can't add files to commit!
    goto:FAIL
)
git commit -m"world update" || (
    cd ..
    echo [GIT SYNC] ERROR: Can't commit change!
    goto:FAIL
)
git push || (
    cd ..
    echo [GIT SYNC] ERROR: Can't push change to remote
    goto:FAIL
)
cd ..


echo [GIT SYNC] Done
timeout /t 3 /nobreak > NUL
goto:EOF

:FAIL
echo [GIT SYNC] ERROR: World was not saved - retry in 10 seconds (press ctrl+c to cancel)...
timeout /t 10 /nobreak > NUL
goto:RETRY_SAVE

:: if "%ATM9_RESTART%" == "false" ( 
::    goto:EOF 
:: )

:: echo Restarting automatically in 10 seconds (press Ctrl + C to cancel)
:: timeout /t 10 /nobreak > NUL
:: goto:START


:: echo Restarting automatically in 10 seconds (press Ctrl + C to cancel)
:: timeout /t 10 /nobreak > NUL
:: goto:START
