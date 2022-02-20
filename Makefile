create:
	kubectl create namespace pihole

apply:
	kubectl apply -f .	

push_config:
	kubectl create configmap app-configs --from-env-file=.env -n pihole

config:
	kubectl describe configmaps pihole-configmap -n pihole

config_2:
	kubectl get configmaps pihole-configmap -n pihole -o yaml

pods:
	kubectl get pods -n pihole

service:
	kubectl get services -n pihole

delete:
	kubectl delete all --all -n pihole
	kubectl delete pvc --all
	kubectl delete pv --all

delete-all:
	kubectl delete namespace pihole

describe:
	kubectl describe pods pihole-0 -n pihole

exec:
	kubectl exec -ti  pihole-0 -n pihole  /bin/bash

logs:
	kubectl logs pihole-0 -n pihole