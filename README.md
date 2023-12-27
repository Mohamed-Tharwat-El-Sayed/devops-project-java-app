# Devops Project: Spring boot java counter 

**Demo app counter deploying by pipeline jenkins and some devops tools like terraform , maven , sonarqube and sonatype nexus.**
       
## Table of Contents:
1. Architecture
2. Introduction
3. Prerequisites
4. Getting Started
5. High Level steps 
6. Low Level Steps
7. After Pipeline
8. Contact


## Architecture

<p align="center">
  <img src="./Project documentation/ProjectArchitecture.png" width="600" title="Architecture" alt="Architecture">
  </p>


### Introduction

This document provides a step-by-step guide for deploying a demo counter application based on Spring-boot-java  by jenkins pipeline on AWS Elastic Kubernetes Service (EKS). The application comprises six tools: `Jenkins`, `Terraform`, `Maven` ,`Sonarqube`,`Sonatype nexus`  and `Docker`.

### Prerequisites

Before you begin, ensure that the following prerequisites are met: (on local)

1. **Docker:** Ensure that docker downloaded , or you can download from [here](https://docs.docker.com/engine/install/ubuntu/) for ubuntu
2.  **Docker compose :** Ensure that docker compose downloaded , or you can download from [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04) for ubuntu

3. **Install Jenkins:** Install jenkins via Docker  way [here](https://www.jenkins.io/doc/book/installing/docker/)

4. **Install sonarqube:** Install sonarqube via Docker compose way [here](https://appinventiv.com/blog/run-sonarqube-with-docker-compose/) 

5.  **Sonatype Nexus:** Install nexus via docker way [here](https://ahgh.medium.com/how-to-setup-sonatype-nexus-3-repository-manager-using-docker-7ff89bc311ce)

6. **Create an AWS Account:** If you do not have an AWS account, create one by following the steps [here](https://docs.aws.amazon.com/streams/latest/dev/setting-up.html).


### Getting Started
### High Level steps (Flow of Application Deployment)

Follow these steps to deploy demo java application:

1. **Jenkins:** Open nexus from browser, which is opened on port `8080`  [Jenkins](http://localhost:8080) and  and put it in terminal 
    
    ```bash
   sudo docker exec <CONTAINER_ID> cat /var/jenkins_home/secrets/initialAdminPassword
    ```
   and install plugins and mange system .

2. **Sonartype nexus:** Open nexus from browser, which is opened on port `8081` [Nexus](http://localhost:8081).

3. **Create repos in Nexus:** open by user `admin` and can enter by
    ```bash
   docker container exec nexus cat nexus-data/admin.password
    ```

   in terminal and put it in password , create two repo in Nexus: `java-app-release` and `java-app-release`.

4. **SonarQube:** Open sonarqube from browser, which is opened on port `9000` [SonarQube](http://localhost:9000)
opened by user: `admin`, password `admin` .

5. **Jenkins configure:**  Install jenkins plugins and Manage credentials for github and docker hub and nexus and sonarqube and slack and aws access key and aws secret key
 and configure  2 new item  
 - one for git and put JenkinsCI on path
 - one for git and put JenkinsCD on path
  then build

6. **Destroying the Infrastructure**  from parameters when configure JenkinsCD pipeline

### Low Level Steps

#### 1. Jenkins

1. **Install required software:** 
    - Enter docker  
       ```bash
       sudo docker ps -a
       sudo docker exec -it -u root <CONTAINER_ID> bash
       apt install sudo curl wget
       ```
        and install docker and maven and terraform and awscli and kubectl

2. **Install plugins:**
   - you must install some plugins for our pipeline
      1. Maven Integration plugin
      2. SonarQube Scanner for Jenkins
      3. Quality Gates Plugin
      4. Sonar Quality Gates Plugin
      5. Pipeline Utility Steps
      6. Nexus Artifact Uploader
      7. Docker Commons Plugin
      8. Terraform Plugin
   
3. **Configure Credentials:** 
   - setting up the credentials
      1. Github (user and pass for Github)
      2. Nexus-credential (user and pass for neuxs)
      3. Dockerhub-credential ( user and pass for dockerhub)
      4. slack_token(genrated token from Jenkins CI From apps)
      5. sonarqube-user-credential (adminstration user token)
      6. aws_access_key (access for account aws)
      7. aws_secret_key (secret for account aws)
  

4. **Manage System:**
   - In manage Jenkins --> system

   <p align="center">
  <img src="./Project documentation/sonarqube-server.png" width="600" title="ekscluster_role" alt="ekscluster_role">
  </p>
  
  **Note:**  you should not use localhost like (http://localhost:9000)
   to solve that put in terminal `ifconfig`
 <p align="center">
  <img src="./Project documentation/ifconfig.png" width="600" title="ekscluster_role" alt="ekscluster_role">
  </p>

  -  In manage Jenkins --> system 
  <p align="center">
  <img src="./Project documentation/slack.png" width="600" title="ekscluster_role" alt="ekscluster_role">
  </p>

5. **Manage tools:**
   - In manage Jenkins --> tools 
    
  <p align="center">
  <img src="./Project documentation/maven-tool.png" width="600" title="ekscluster_role" alt="ekscluster_role">
  </p>

6. **Create 2 pipeline:**
   - new item
   - pipline defination -> pipeline script form SCM
   - put repo link
   - put credential 
   - path (first repo JenkinsfileCI. second repo JenkinsfileCD)

#### 2. SonarQube

1. Go to adminstration to security to users and genrate token to user and put it in jenkins crediential
2. Go to configration to webhooks and create (with same private ip)
<p align="center">
  <img src="./Project documentation/sonarqube-webhook.png" width="600" title="Node_IAM" alt="Node_IAM">
  </p>

3. Go to quality gates and create condition
<p align="center">
  <img src="./Project documentation/qulity-gate.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>

#### 3. Sonatype Nexus
1.  Sign in with user admin and new password 
2.  Create two repo (one for release and another for snapshot)with it configration (type:hosted, format:maven2)
3.  update JenkinsfileCI with you private ip

###  After pipeline
1. In jenkins 
- you see demo-app-java-CI
<p align="center">
  <img src="./Project documentation/ci-pipeline.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>
-  you see demo-app-java-CD parameters
<p align="center">
  <img src="./Project documentation/parameters.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>
-  you see demo-app-java-CD
<p align="center">
  <img src="./Project documentation/cd-pipeline.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>

2. In nexus 
- you can see war files in two repo 
<p align="center">
  <img src="./Project documentation/war-files.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>
  
3. In sonarqube 
- you can see status of the project
<p align="center">
  <img src="./Project documentation/Project-status.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>

4. On browser
- on jenkins container 
  ```bash
  sudo docker exec -it  <CONTAINER_ID> bash
  docker get all 
  ```
-  <p align="center">
  <img src="./Project documentation/on-browser.png
  " width="600" title="Node_IAM" alt="Node_IAM">
  </p>

## Contact

For inquiries, please contact [Mohamed Tharwat] at [Mohammed.Tharwat.Elsayed@gmail.com].
