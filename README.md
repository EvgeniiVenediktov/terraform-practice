# Terraform practice
## AWS ParallelCluster

### Setup:
```bash
cd tf-aws-parallelcluster
terraform fmt -recurvive
terraform validate
terraform plan -out=tfplan

# Set up networking
terraform apply tfplan

# Set up cluster
pcluster create-cluster \
    --cluster-name hpc-pcluster \
    --cluster-configuration ./generated/cluster-config.yaml \
    --rollback-on-failure true

# See status
aws cloudformation describe-stack-events \
  --stack-name hpc-pcluster \
  --query "StackEvents[:5].[ResourceStatus,LogicalResourceId]" \
  --output table

# Connect to the head node
pcluster ssh --cluster-name hpc-pcluster -i ~/.ssh/hpc-key
```
### Teardown:
```bash
# Delete cluster
pcluster delete-cluster --cluster-name hpc-pcluster

# See status
aws cloudformation describe-stack-events \
  --stack-name hpc-pcluster \
  --query "StackEvents[:5].[ResourceStatus,LogicalResourceId]" \
  --output table

# Update TF state
terraform destroy
```

```
[ec2-user@ip-10-0-1-103 ~]$ sinfo -N -l
Fri Mar 06 01:01:39 2026
NODELIST                    NODES PARTITION       STATE CPUS    S:C:T MEMORY TMP_DISK WEIGHT AVAIL_FE REASON              
compute-dy-hpc-x86-nodes-1      1  compute*       idle~ 48     48:1:1 747110        0   1000 dynamic, none                
compute-dy-hpc-x86-nodes-2      1  compute*       idle~ 48     48:1:1 747110        0   1000 dynamic, none                
compute-dy-hpc-x86-nodes-3      1  compute*       idle~ 48     48:1:1 747110        0   1000 dynamic, none                
compute-dy-hpc-x86-nodes-4      1  compute*       idle~ 48     48:1:1 747110        0   1000 dynamic, none                
compute-dy-hpc-x86-nodes-5      1  compute*       idle~ 48     48:1:1 747110        0   1000 dynamic, none 
```



### Get head node IP:
```
pcluster describe-cluster --cluster-name hpc-pcluster --query headNode.publicIpAddress
```


