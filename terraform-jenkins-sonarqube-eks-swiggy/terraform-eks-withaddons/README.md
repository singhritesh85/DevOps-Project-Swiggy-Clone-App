# terraform-eks
```
1. First of all clone this repository and change the directory to "terraform-eks-withaddons".
2. Run the shell script initial-setup.sh only once on your k8s-management-node or terraform-server. As this script will install the kubectl, helm and uninstall awscli version 1.x then install awscli version 2.x. After running this shell script just logout from the logged-in user and then login again.
```

# Install and configure EKS Container Insight 
```
curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/cluster-name/;s/{{region_name}}/cluster-region/" | kubectl apply -f -
```

In this command, cluster-name is the name of your Amazon EKS or Kubernetes cluster, and cluster-region is the name of the Region where the logs are published. We recommend that you use the same Region where your cluster is deployed to reduce the AWS outbound data transfer costs.

```
curl https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluentd-quickstart.yaml | sed "s/{{cluster_name}}/eks-demo-cluster-dev/;s/{{region_name}}/us-east-2/" | kubectl apply -f -
```

Then go to EC2 Instance created as a part of NodeGroup of this EKS Cluster and open it's IAM Role and attach the policy CloudWatchLogsFullAccess . Finally go to Cloudwatch Console, Open Insights > Container Insights. 



Reference:- https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-quickstart.html
