# Get the IP address of the VM
IP=$(minishift console --url | cut -f2 -d':' | cut -f3 -d'/')

echo $IP

# Get the NodePort of the service
NODEPORT=$(kubectl --namespace=kubedemo get services mynode -o yaml | grep nodePort | cut -f2 -d:)

echo $NODEPORT

# Combine the two, trimming off whitespace
THEURL=$IP:$(echo $NODEPORT | awk '{print $1}')/hello

echo $THEURL

# curl it
while true
do 
  curl --connect-timeout 1 -s $THEURL;
  echo
  sleep 1;
done