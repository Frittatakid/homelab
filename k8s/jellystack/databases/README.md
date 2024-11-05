kubectl create ns db

k apply -f .\manifests\jellystack\databases\postgres-sonarr.yaml

k apply -f .\manifests\jellystack\databases\postgres-radarr.yaml
