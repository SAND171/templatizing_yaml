# Kubernetes helm chart for IZAC


## Configure helm

```
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

## Install IZAC helm charts

```
# To install helm chart with name "izac"
helm install --name izac izac-helm-charts

# To get pods
kubectl get pods

# To get services
kubectl get svc

# To give access to joblauncher
kubectl create clusterrolebinding joblauncher-binding --clusterrole=admin --serviceaccount default:izac-joblauncher
```


## Managing the release

```
# To get all helm releases
helm ls

# To delete a release
helm del --purge izac

# To change anything after installing a release
helm upgrade izac izac-helm-charts
```

## Managing pods

```
kubectl describe pod <pod-name>
kubectl logs --follow <pod-name>
kubectl delete pod <pod-name>
```

## Managing GKE cluster

```
gcloud compute firewall-rules create myservice --allow tcp:30000-32767
gcloud compute instances list
gcloud container clusters resize standard-cluster-1 --num-nodes=1 --zone us-central1-a
```

## Setting up NGINX-Ingress

```
# Create static IP
gcloud compute addresses create izac-ip --region us-central1

# Get static IP
gcloud compute addresses describe izac-ip --region us-central1

# Install ingress controller
helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.service.loadBalancerIP="<regional-static-ip>"

# Save the below text and change service name, host and path
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/ingress.global-static-ip-name: izac-ip
  name: ingress
spec:
  rules:
    - host: www.example.com
      http:
        paths:
          - backend:
              serviceName: exampleService
              servicePort: 80
            path: /

# Then apply the file
kubectl apply -f <ingress-file>.yml
```