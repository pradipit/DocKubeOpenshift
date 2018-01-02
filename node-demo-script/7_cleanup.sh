route="kubectl delete route --namespace=kubedemo mynode"
echo $route
$route

service="kubectl delete svc --namespace=kubedemo mynode"
echo $service
$service

deployment="kubectl delete deployment --namespace=kubedemo mynode"
echo $deployment
$deployment

namespace="kubectl delete namespace --namespace=kubedemo kubedemo"
echo $namespace
$namespace

