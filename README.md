## Prerequisites

- Terraform(0.11.x)
- Python
- AWS cli

## Set AWS credentials

Login with your AWS credentials.

```
aws configure
```

Set the required environment variables for the Terraform scripts.

```
export AWS_DEFAULT_REGION="us-west-2"
export DNSIMPLE_TOKEN=XXX
export DNSIMPLE_ACCOUNT=1234
```

## tfvars file

Configure `terraform.tfvars` file for the required cluster setup. This includes setting the AWS region where the cluster will run, the size of the nodes etc.

## Create infra for cluster

```
terraform init
terraform apply
```

The last command requires prompting. Make sure you store the `terraform.tfstate` file in a safe place. It is used by Terraform to track state and will be required when adding new nodes.

## Prepare inventory

Rewrite the inventory file according to the domain you created. A sample inventory file can be found.

Change the htpassword entry in the inventory. Add more users if required.

```
htpasswd -nbB admin SuperSecretPassword
```

## Provision OpenShift

Clone the official OpenShift Ansible playbooks.

```
git clone https://github.com/openshift/openshift-ansible.git  --branch release-3.11
```

Prepare `ansible.cfg` and use the ssh key added in the Terraform step.

Create a new virtualenv to install Ansible and required dependencies.

```
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

Add the `openshift-aws-user` IAM user's access keys as env variables. This is referred by the playbook when installing AWS specific stuff like storage classes.

These can be found in the `terraform.tfstate` file. Search for `aws_iam_access_key` in the file.

```
export AWS_ACCESS_KEY_ID=XXX
export AWS_SECRET_ACCESS_KEY=YYYY 
```

Run the pre-install playbook.

```
ansible-playbook pre-install.yml
```

Run prerequisites playbook.

```
ansible-playbook playbooks/prerequisites.yml
```

Run the cluster provisioning playbook.

```
ansible-playbook playbooks/deploy_cluster.yml
```

Takes around 40 minutes. After that you should be able to login to the web console in the following URL:

https://console.<cluster-domain>:8443/

You will get an invalid SSL certificate warning.

## Add new nodes

### Create infrastructure

Make sure you have the last run's `terraform.tfstate` file in the Terraform directory. Update `terraform.tfvars` file to add new nodes in the `node_sizes` variable.

Apply the new changes.

```
terraform apply
```

### Update inventory

Add the new node in the `[new_nodes]` section of inventory.

### Provision new node

Run the pre-install on new nodes.

```
ansible-playbook -l new_nodes pre-install.yml
```

Run the scale up playbook.

```
ansible-playbook playbooks/openshift-node/scaleup.yml
```

Verify that the nodes are added by running `oc get nodes` and ensuring that you have the new node.


### Update inventory again

Move the newly added node back to `[nodes]` section.

## Technical details

This setup installs a single master based OKD 3.11 cluster. It uses EBS as the default storage class. It uses external DNS to setup the cluster(currently DNSimple), but can be configured to use internal DNS/Route53/CloudFlare or any other DNS solution. The only pre-condition is that there should be a Terraform module for that.

## TODO/Limitations

You can add nodes and setup the cluster only in 1 region/availability zone.

## Contact

If you have any feedback, need to modify this setup/have it installed at your own infrastructure or have any questions around it, don't hesitate to contact me.

email: [lakshmi AT shapeblock.com](mailto:lakshmi@shapeblock.com)

Twitter: [@lakshminp](https://twitter.com/lakshminp)

