kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl delete -f srcs/nginx/nginx.yaml
kubectl delete -f srcs/mysql/mysql.yaml
kubectl delete -f srcs/wordpress/wordpress.yaml
kubectl delete -f srcs/phpmyadmin/phpmyadmin.yaml
kubectl delete -f srcs/ftps/ftps.yaml
kubectl delete -f srcs/grafana/grafana.yaml
kubectl delete -f srcs/influxdb/influxdb.yaml
kubectl delete -f srcs/telegraf/telegraf.yaml

# Delete previous cluster
minikube delete

# Allow docker to run (password on VM is "user42")
sudo usermod -aG docker $(whoami)

# Start the cluster
minikube start --vm-driver=docker

if [[ $? == 0 ]]
then
    eval $($sudo minikube docker-env)
    printf "Minikube started\n"
else
    $sudo minikube delete
    printf "Error occured\n"
    exit
fi

# Find IP using kubectl get node
CLUSTER_IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"

# Change IP to match your machine (normally it is 172.17.0.3)
sed -i 's/172.17.0.3/'$CLUSTER_IP'/g' srcs/metallb/metallb.yaml
sed -i 's/172.17.0.3/'$CLUSTER_IP'/g' srcs/nginx/nginx.conf
sed -i 's/172.17.0.3/'$CLUSTER_IP'/g' srcs/wordpress/entry.sh
sed -i 's/172.17.0.3/'$CLUSTER_IP'/g' srcs/ftps/start.sh
sed -i 's/172.17.0.3/'$CLUSTER_IP'/g' srcs/telegraf/telegraf.conf

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb/metallb.yaml

# Build-apply both docker build and kubectl apply 
# a same repository containing the dockerfile and yaml deployment
build_apply ()
{
    docker build -t services/$1 srcs/$1
    sleep 1
    kubectl apply -f srcs/$1/$1.yaml
}

services="nginx mysql wordpress phpmyadmin ftps influxdb telegraf grafana"

for service in $services
do
    build_apply $service
done

minikube dashboard