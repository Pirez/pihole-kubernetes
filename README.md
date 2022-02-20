
# Pihole on Kubernetes

## HOW-TO

This section covers how to setup pihole on a kubernetes cluster. Most of the commands to interact with the service is covered in the `Makefile`, feel free to have a look.

### Guide

First create a namespace:

```
kubectl create namespace pihole
```

Then setup the `.env` for your

```
ADMIN_EMAIL: "<email>"
WEBPASSWORD: "x"
PIHOLE_DNS_: 1.1.1.1
```

Please check the documentation for setting up the latests updated paramaters [docker pihole](https://hub.docker.com/r/pihole/pihole).

add the configmap to your cluster

```
kubectl create configmap app-configs --from-env-file=.env -n pihole
```

⚠️ Remember to change your `loadBalancerIP` to a static ip that fits your cluster. 


Confirm that pihole is running:
```
kubectl get pods -n pihole
NAME       READY   STATUS    RESTARTS   AGE
pihole-0   1/1     Running   0          3d13h
pihole-1   1/1     Running   0          3d13h
``` 

Voila, pihole should be up and running 🤓

### ConfigMap

If you don't want to use an `.env` file to setup the configmap, you can add it straight into `pihole.yml`.

```
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: pihole-configmap
  namespace: pihole
data:
  TZ: "Europe/Paris"
  ADMIN_EMAIL: "xxx@gmail.com"
  WEBPASSWORD: "xxx"
  PIHOLE_DNS_: 1.1.1.1
---
```

## Unbound
If you want to setup [Pi-hole unbound/](https://docs.pi-hole.net/guides/dns/unbound/), you need to run unbound on the kubernetes cluster. Again, remember to change `loadBalancerIP` in `unbound.yaml` to your own static ip. Then  set `PIHOLE_DNS_` to point to unbound service.

### Source
The templates are either copy-pasted or based on these sources:
* https://greg.jeanmart.me/2020/04/13/self-host-pi-hole-on-kubernetes-and-block-ad/
* https://github.com/ivanmorenoj/k3s-pihole-wireguard
* https://github.com/timwebster9/pihole-microk8s-demo/blob/master/pihole-privileged.yaml