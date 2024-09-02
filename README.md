# world_scripts

## Prerequisites:
### [CLIENT SIDE] Minecraft ATM9 (All the mods 9)
1. Download polyMC launcher (https://polymc.org/download/)
2. Setup ATM9 minecraft instance (version 0.3.0)
   * be sure to install java (version >= 17)
   * add user account
3. (optional) add Complementary shaders (https://resourcepack.net/complementary-shaders)
   
### (optional) [SERVER SIDE] Sync world with remote
1. Download and setup git (https://git-scm.com/download/win)
2. Generate (if necessary) ssh keys (https://www.purdue.edu/science/scienceit/ssh-keys-windows.html)
3. Add ssh key (content of id-rsa.pub) to your Github account (https://github.com/settings/keys)
4. Get access rights to https://github.com/Destice/world
5. Download Minecraft-server-ATM9 (version 0.3.0) files from https://www.curseforge.com/minecraft/modpacks/all-the-mods-9/files/5564414


## How to use:
### [CLIENT SIDE] Connect to server
1. Launch ATM9 and connect to server (contact me for ip)

### (optional) [SERVER SIDE] Launch own server instance
1. Download scripts and place in minecraft server directory
2. Configure server properties file, accept EULA
3. Start server by executing `startserver.bat`
4. Be sure to stop server using `stop` command in terminal
