# Should have 4 Modes of Deployment

# Embedded Kafka
# External Kafka Cluster
# Azure Event Hub

#!/bin/bash

#find the image list with given repository url
find_image_list(){
        echo "$(gcloud container images list --repository=$1)"
}

#with given an image get the lattest tag
getLatestImageTag(){
        echo  "$(gcloud container images list-tags $1 | awk '{if($3!=""){print $3,$1,$2}}' | sort -nr | awk 'NR==1{print $3}')"
}

#intallation of helm charts with lattest image tag 
helm_install() {
       echo "helm installation"
       var1=$(find_image_list $1)
       i=1
       for j in $var1
       do 
              if [ $i == 1 ]
              then
                     i=i+1
                     continue
              else
                     
                      #echo -n "$j"
                      #echo -n "   "
                      a=$(getLatestImageTag $j)
                      chart_name=${j##*/}
                      #echo $chart_name
                      helm upgrade --install izac ./izac-helm-charts --set $chart_name.image.repository=$j --set $chart_name.image.tag=$a
                     
                     #echo "$a"
                      i=i+1
              fi

       done
}

deploy_embedded_kafka() {
 echo "Starting deployment Embedded"
}
  
deploy_external_kafka() {
echo "external_kafka_function"
}
 
deloy_azure_event_hub() {
 echo "deploy_azure_event"
}
  
set_container_registry() {
 echo "set_container_regstry"
 
}



#List all Images  with latest tag
 
find_images_list_and_tag()
{
       var1=$(gcloud container images list --repository=$1) 
       i=1
       for j in $var1
       do 
              if [ $i == 1 ]
              then
                     i=i+1
                     continue
              else
                     
                      echo -n "$j"
                      echo -n "   "
                      a=$(getLatestImageTag $j)
                      
                      echo "$a"
                      i=i+1
              fi

       done
}
#gcloud container images list --repository=gcr.io/izackubernetes/izac/master
install_gcp_sdk() {
       echo "install_gcp_sdk"
       var=$(cat /etc/os-release | awk '/^ID=/'{print}|grep -o '".*"' | sed 's/"//g')
       echo $var
       if [ $var == "ubuntu" ]
       then
              echo "you are on ubuntu machine so now you are going to install gcp"
              sudo apt-get install apt-transport-https ca-certificates gnupg  # it will install the utility 
              echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
              curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
              sudo apt-get update && sudo apt-get install google-cloud-sdk
              sudo apt-get install google-cloud-sdk-app-engine-java
              sudo apt-get google-cloud-sdk-app-engine-python
              sudo apt-get install kubectl
              gcloud init
       
 #first check centos version if it is centos7 then proceed and if it is centos8 then replace the below baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64 
 else [ $var == "centos" ] 
       echo "you are in CentOs machine and now you are about to install gcp"
      sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
       yum install epel-release -y
       yum install dnf -y
       sudo dnf install python3 
       sudo dnf install google-cloud-sdk
       sudo dnf install kubectl
       echo "enter the file name with path  to authenticate the gcp "
       read input_file
       gcloud auth activate-service-account --key-file "$input_file"
    
 fi
 }

##====================================================
#INSTALLATION START
##====================================================

echo "we are about to start izac_installer_project"
echo "enter 1 to deploy_embedded_kafka
      enter 2 to deploy_external_kafka
      enter 3 to deploy_event_hub
      enter 4 to set_container_registry 
      enter 5 to install gcp sdk
      enter 6 to find the lattest tag of images
      enter 7 to insatll helm deployment
      enter 8 to exit from installation
     "
echo "enter your choice !"
read choice
case "$choice" in
         1) echo "we are in embeded kafka" 
                deploy_embedded_kafka
                   ;;
 
         2) echo "we are in external_kafka" 
                deploy_external_kafka
                 ;;
 
         3) echo "we are in azure event hub" 
                 deloy_azure_event_hub
                 ;;
                  
         4) echo "we are about to set container registry"
              set_container_registry
                 ;;
 
         5) echo "we are about to install gcp sdk"
              install_gcp_sdk
                ;;

         6) echo "we are going to find the lattest images tag"
                
                echo "enter the repository_url" 
                read REGISTRY_URL
                find_images_list_and_tag $REGISTRY_URL
                ;;

         7) echo "we are in helm installation"
                echo "enter the repository_url" 
                read REGISTRY_URL
                helm_install $REGISTRY_URL
                ;;
         
         8) echo "exiting  from the loop without performing any action"
                
esac