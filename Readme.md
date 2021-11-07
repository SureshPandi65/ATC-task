####Description:

This document has instructions on how to deploy a containerised version of python web application in AWS using EKS.
This python web application have a simple static page that displays the values stored in the dockerfile's environment variables “ATC_USERNAME” & “ATC_PASSWORD”.

####Plan of action:

1. Terraform used to provision the cloud infra.
2. Dockerfile used to create a python container which display the environment variables using django web framework.
3. Kubernetes used create and manage the python container using the docker image which is stored in the docker hub.
4. This implementation is designed to be launched in aws region us-west-2

####Requirements: 

1. Terraform v1.0.10
2. AWS Account with a user or role access to `ec2:*`, `eks:*`, IAM access to create,delete,attach,detach IAM roles and policies 
3. kubectl v1.19.2 (Preferred).
4. aws cli version aws-cli/2.0.52 (`aws --version`)
5. Basic knowledge of AWS, Terraform and Kubernetes.

####List of Resources Deployed by the terraform:

1. VPC (1)
2. Subnets (4, 2 - Public, 2-Private)
3. Route Tables (2)
4. Internet Gateway (1)
5. IAM Roles (2)
6. EKS Cluster (1)
7. EKS node groups (1, EC2 - 1 t3.medium)
8. Classic Load Balancer (1, Created by kubernetes service. not by terraform)


####Terraform Deployment:

1. Navigate into `terraform-templates` directory.
2. Run the command `terraform init`. 
3. Run the command `terraform plan` .
4. Once the previous command completes successfully, run the command `terraform apply`
The deployment takes around 20 to 30 minutes with EKS cluster and EKS nodes taking the longest time for creation.

####Kubernetes Deployment:

1. Navigate to `kubernetes-yamls` directory 
2. connect to the kubernetes cluster using below aws-cli command

`aws eks --region ap-south-1 update-kubeconfig --name eks-aps1-terraform`

3. Once successfully connected to the cluster, enter the below commands in the same order.
`
kubectl apply -f deployment.yaml
`
5. Check whether the pod is running using the following command `kubectl get po -n default`
```
Sample Output:
NAME                    READY   STATUS    RESTARTS   AGE
serviantest-<podhash>   1/1     Running   0          26s
```

6. Once the pod is runnning, enter the following command `kubectl apply -f service.yaml`
7. Check whether the service was created successfully using the command `kubectl get svc -n default`
```
Sample Output:
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP                                          PORT(S)        AGE
kubernetes        ClusterIP      172.20.0.1      <none>                                               443/TCP        43m
servian-service   LoadBalancer   172.20.106.60   <bigautomatedhasg>.ap-south-1.elb.amazonaws.com      80:32622/TCP   16s

```
 Wait for 5 minutes and then copy the URL displayed under the `EXTERNAL-IP` and load it in the browser. The home page of the app will load in a second or two.