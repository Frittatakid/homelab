we will be creating a streaming stack that will enable download, processing and watching of video media.

kubectl create namespace jellystack

the stack contains the following apps:

bazarr: subtitle downloader
jackett: finds torrents
jellyfin: media watcher
jellyseerr: media browser
radarr: film info getter
sonarr: show info getter
transmission: torrent downloader