# Use to point your shell to minikube's docker-daemon
& minikube -p minikube docker-env | Invoke-Expression

# minikube addon to use ingress object in the k8s cluster
minikube addons enable ingress

# Build the docker image for our Flask application based on the dockerfile in the same directory
docker build --tag treeassignment-app .

Write-Host "This is the name of our Tree Assignment image that will be used to create our Pod" -ForegroundColor Red -BackgroundColor Yellow
docker images | Select-String "treeassignment-app"
Start-Sleep -s 3

# Navigate to the "terraform" folder that contain the main.tf used to create our K8s configuration
cd ./terraform
Write-Host "This is the current resources in K8S before terraform apply" -ForegroundColor Red -BackgroundColor Yellow
kubectl get all -n treeapp-namespace
Start-Sleep -s 3
Write-Host "Let's create our configuratin in K8S with Terraform" -ForegroundColor Red -BackgroundColor Yellow

# Terraform commands to create our configuration in Kubernetes based on main.tf in the same folder
terraform init
terraform plan
terraform apply -auto-approve
kubectl get all -n treeapp-namespace

# 40s to wait to get the ingress IP address
Start-Sleep -s 40
kubectl get ingress treeassignment-ing -n treeapp-namespace
Write-Host "Please use the ingress external IP into your hosts file to locally reach local.ecosia.org" -ForegroundColor Red -BackgroundColor Yellow