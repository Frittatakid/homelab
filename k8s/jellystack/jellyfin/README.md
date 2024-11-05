The kubernetes deployment for jellyfin works not optimally in kubernetes due to sqllite issues.

The implementation here is a docker compose file that brings up the jellyfin server with the network setting "host" to 
straight up expose the ports on the VM.

There is a rc.local script which goes into /etc/ that will wait a bit so everything mounts and then run the container.

