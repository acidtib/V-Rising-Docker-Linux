# Docker container for linux vrising server 

using Wine in an ubuntu container

This isn't really meant to be a guide, just publishing because at the moment not much info on setting this up out there. I'm no docker expert so there's probably a better way to go about this. Sorry if these steps aren't 100% accurate: 

1. Clone the repo  
`git clone https://github.com/Googlrr/V-Rising-Docker-Linux`

2. CD to the directory  
`cd V-Rising-Docker-Linux`

3. Modify the `ServerGameSettings.json` and `ServerHostSettings.json` to your liking.

4. Move the files in `settings/` to a new location (e.g. `/opt/vrising/settings/`).
 
5. Modify docker compose and set the save and settings volumes according to step 4 (e.g. `/opt/vrising/settings` and `/opt/vrising/server`)

6. Update `ENV TZ="America/New_York"` in `dockerfile` to [your timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

7. Modify docker compose, set a path for where you want your saves. Set the save and settings directories

8. compose
sudo docker-compose up -d 


# Updating the server
Before and after updating the server it might be sensible to check the currently running version:  
`docker logs vrising-server | grep "VRisingServer v" -A1 | tail -2` 

This container only downloads/updates the server application when `/root/.wine/drive_c/steamcmd/steaminstalled.txt` (which is created on first startup) does not exist inside the container. There are two ways to update the server:
- `docker exec vrising-server rm /root/.wine/drive_c/steamcmd/steaminstalled.txt && docker restart vrising-server`  
to delete the file and restart the container, which updates the already installed server.  

- `docker-compose up --build -d`  
to recreate the container from scratch without `steaminstalled.txt`.
