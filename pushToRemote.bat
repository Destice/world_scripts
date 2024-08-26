:RETRY_SAVE
echo [GIT SYNC] Pushing local "world" to remote git@github.com:Destice/world.git
(
    cd world
    git add .
    git commit -m"world update"
    git push
    cd ..
) || (
    echo [GIT SYNC] Error during push!!! Retrying in 10 seconds (press Ctrl + C to cancel) - WORLD WILL NOT BE SAVED ON REMOTE!!!
    echo [GIT SYNC] you can try to manually upload or execute "pushToRemote.bat" later
    timeout /t 10 /nobreak > NUL
    goto:RETRY_SAVE 
)