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


Not yet sure if i should deploy this in a whole fat pod with all the containers or just on separate pods, but i think it
will be easier for now to do it separately and then change it in the future to optimize if needed.

I will be exposing each one of those services as clusterIPs and then using an ingress to access it via different paths.

