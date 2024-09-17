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

------------------

v.0.1.
I will expose individually each service through a LB to make sure they all work alright.
The Ip range will be 192.168.0.230-240

I created jellyfin-lb.yaml, which exposed the jellyfin server on the specific address pool which i created beforehand (ippool-jellystack.yaml)
exposing the jellyfin port to port 80 for ease of access.
