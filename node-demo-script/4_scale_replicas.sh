command='kubectl --namespace=kubedemo scale deployment mynode --replicas=3'
echo $command 
$command