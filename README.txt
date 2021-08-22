ABOUT THE ASSIGNMENT
--------------------
+The assignment consists of two major parts:
 Coding a web server
 Automating its deployment into a Kubernetes cluster



GETTING STARTED
---------------
+Environment
 This assignment was delivered on a Windows 10 machine using minikube as a local K8s environment

+Prerequisites
 Have kubectl installed on the windows machine
 Have VirtualBox installed on the windows machine
 Have minikube installed on the windows machine and configure VirtualBox as driver
 Have docker installed on the windows machine
 Have terraform installed on the windows machine

+WebServer application technology
 Flask with Python



PROJECT INSTALLATION FILES EXPLANATION
--------------------------------------
+Folder "Assignment/"
 Dockerfile --> Contains the steps to build our Flask application
 deployment.yaml --> File to create our application deployment in Kubernetes
 service.yaml --> File to create our application service in Kubernetes
 ingress.yaml --> File to create our ingress in Kubernetes
 namespace.yaml --> File to create our dedicated assignment namespace in Kubernetes (deployment, service, ingress will be part of this namespace)
 script.ps1 --> Script to take care of building, packaging and deploying our Flask application and configuring the minikube k8s cluster

+Folder "Assignment/terraform"
 main.tf --> Terraform configuration file to setup our k8s configuration. This file takes all the k8s yaml files into 1 Terraform configuration file.



INSTALLATION
------------
+Prerequisites
 Make sure all the prerequisites are properly installed on the Windows machine

+Step to execute
 Unzip and Copy/Paste the "Assignment" folder on your machine
 On your Windows machine, open TWO Powershell windows as Administrator
++Steps on the 1st Powershell window
  Navigate to the "Assignment" folder
  Type "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
  Type "minikube start --driver=virtualbox"
  Type "kubectl config view" and copy the following values to the file "Assignment\terraform\main.tf" as follow:
   server: https://XXX.XXX.XXX.XXX:8443 to the "host" value in the Provider section
   client-certificate: XXXXXXXXX.crt to the "client_certificate" value in the Provider section
   client-key: XXXXXXXXX.crt to the "client_key" value in the Provider section
   certificate-authority: XXXXXXXX.crt to the "cluster_ca_certificate" value in the Provider section
  Save the file "main.rtf"
++Steps on the 2nd Powershell window
  As soon as minikube is started (from the other Powershell window), type "minikube tunnel" and leave the window open
++Steps on the 1st Powershell window
  Type "./script.ps1" to execute the script and wait until done
  Configure your windows hosts file with IP and Host of your K8s Ingress (you can retrieve by typing "kubectl get ingress -n treeapp-namespace")

+Verification
 Verify that you get a JSON response with the FavoriteTree (should be LemonTree) using curl http://local.ecosia.org/tree

