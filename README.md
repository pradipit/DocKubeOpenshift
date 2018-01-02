# DocKubeOpenshift
Kubernates Demo Script

Prerequisite
Install Minishift
Install OC CLI
Install kubectl CLI

Start Minishift local Cluster

> minishift version
> minishift start --vm-driver=virtualbox

The server is accessible via web console at:
    https://192.168.99.100:8443

Check opneshift cli to access the resources.

> oc login -u developer -p test
> oc get projects

Check whether kubectl cli is working by using some command

> kubectl get namespaces

> minishift docker-env

Source docker env variable which running inside minishift cluster

> minishift docker-env

List the running containers and images inside the minishift

> docker images
> docker ps

Get the console URL:
> minishift console --url
> developer/test

Now we will build docker images from Dockerfile

Cd to node-demo

> minishift docker-env

> docker build -t pc/mynode:v1 .

> docker images | grep mynode

> docker run -d -p 8000:8000 pc/mynode:v1

> docker ps | grep mynode

> docker exec -it fe2ab3012e69 /bin/bash

> cat /etc/system-release

> exit

> docker stop fe2ab3012e69

> docker rm fe2ab3012e69

It creates an images pc/mynode with tag v1

Now change content of hello-http.js file and perform same above step with tag v2.

At the end, we have two images of pc/mynode with v1 and v2 tags.

To Orchestate the docker container, we are using docker-compose command.

For example,

cd node-demo-script/

Create docker-compose.yml

version: '2'
services:
  mynodev1:
    container_name: mynodev1
    image: pc/mynode:v1
    hostname: mynodev1
    ports:
      - "8081:8000"
  mynodev2:
    container_name: mynodev2
    image: pc/mynode:v2
    hostname: mynodev2
    ports:
      - "8082:8000"

And run docker-compose up -d

Now, here kuberenates comes in rescue to manage and orchestrate your docker conainer.

Now, we will run node demo:

Namespace:

kubectl cluster-info
vi kubedemo-namespace.yaml
apiVersion: v1
kind: Namespace
metadata: 
  name: kubedemo

> ./0_setup.sh
> ./1_create-namespace.sh

> kubectl get namespaces

Pods:

> kubectl get pods
> kubectl --namespace=kubedemo get pods

> ./2_create-pod.sh
> kubectl --namespace=kubedemo get pods
> kubectl --namespace=kubedemo get deployments
> kubectl --namespace=kubedemo describe deployments
> kubectl --namespace=kubedemo logs mynode-3397586514-4fv5p (pod)
> kubectl --namespace=kubedemo exec -it mynode-3397586514-4fv5p bash
> cat /etc/hostname
> cat /etc/system-release
> Exit

Services:
Now expose the service for mynode deployment
> ./3_expose_service.sh
> kubectl --namespace=kubedemo get services mynode

Now, hit http://192.168.99.100:30643/ link on browser

> kubectl --namespace=kubedemo describe svc mynode *

Deployments:
When you create pod it will create deployment for you.
> ./4_scale_replicas.sh
> kubectl --namespace=kubedemo get deployment mynode
> kubectl --namespace=kubedemo get pods

Now curl this url multiple time to see load get distributed 
> curl 192.168.99.100:30643

Or 

>./5_curl_service.sh

Rolling Upgrade:
https://ryaneschinger.com/blog/rolling-updates-kubernetes-replication-controllers-vs-deployments/

Self-healing:
> kubectl --namespace=kubedemo get pods
> kubectl --namespace=kubedemo delete pod mynode-3397586514-8d16h



Route:
> kubectl --namespace=kubedemo get services
> oc project kubedemo
> oc expose service mynode
> oc get routes
http://mynode-kubedemo.192.168.99.100.nip.io/

Clean up:
> ./7_cleanup.sh
Proxy:
This command starts a proxy to the Kubernetes API server:
> kubectl proxy 
	Starting to serve on 127.0.0.1:8001

Hit http://localhost:8001/api/v1/namespaces/kubedemo/pods/mynode-3397586514-4fv5p link on browser to get the details pod yaml content.

minishift ssh
