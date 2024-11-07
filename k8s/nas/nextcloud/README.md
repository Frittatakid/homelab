nextcloud is kinda finnicky with how it's installed, apply the yaml modifying the variables if needed


you may need to tinker the config.php file that is generated after installation
Add your domain to the trusted domains variable. space separated values if multiple.
Here is a reference on all variables and stuff https://hub.docker.com/_/nextcloud

access the service and you will get an installation screen. Adjust as needed any issues that pop up.

tip: there is a bug with the login in chromium which gets stuck and you need to refresh to go through the login screen. 
to fix it you got to add/modify the config.php with:

{...} 
'overwrite.cli.url' => 'https://your.domain', 
'overwritehost' => 'your.domain', 
'overwriteprotocol' => 'https', 
{...}

