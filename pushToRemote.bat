@echo off
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
