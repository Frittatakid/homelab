
access to the network attached filesystem will be through filebrowser and complimented by sist2 as an indexed search engine.




k create ns nas #namespace for filesystem related stuff

Keep an eye for the database and settings files mounted on the filebrowser.

default admin user for management, individual users with their own directory and a shared folder.
This shared folder is just a relative and symbolic link inside every one of the users directories.

ln -r -s shared/ (user directory)




Nexcloud seems fairly powerful, ill test it on its own namespace installing it through helm.

helm repo add nextcloud https://nextcloud.github.io/helm/
helm install my-release nextcloud/nextcloud -n nextcloud