# OpenShift Terraform

This project sets up an OpenShift Origin cluster (v3.9 currently) on a DigitalOcean infrastructure. The infrastructure creation and generation of inventory files is handled by Terraform. The goal of the project is to eventually add support for various cloud providers.


## Overview

A lot of this setup is insipred by [Get up and running with OpenShift on AWS](http://www.dwmkerr.com/get-up-and-running-with-openshift-on-aws/). Here's a 10k ft view of how the setup looks like.

**TODO: add diagram**

## Prerequisites

1. [Terraform](https://www.terraform.io/intro/getting-started/install.html) Download and install terraform for your OS.
2. Ansible
3. A DigitalOcean account with a ReadWrite Token generated.

## Creating the Cluster

### Provision the infrastructure



```
$ export TF_VAR_domain=<your-base-domain-name>
$ export DIGITALOCEAN_TOKEN=<do-token>
$ terraform init
$ terraform apply
```

Generate SSH keypair specific to this cluster. It is called `tf` and `tf.pub` by default. If you call it by a different name, change it in `variables.tf`.

```
$ terraform apply
```

This will generate 2 inventory files,

`preinstall-inventory.cfg` for installing the prerequisites in the Open Shift cluster.

`inventory.cfg` needed for the Ansible OpenShift installer.

### Install prerequisite software

```
$ ansible-playbook -u root --private-key=~/.ssh/tf -i preinstall-inventory.cfg ./pre-install/playbook.yml
```

### Install OpenShift cluster on provisioned infrastructure

Clone the playbook for v3.9.

```
$ git clone git@github.com:openshift/openshift-ansible.git --branch release-3.9 --depth 1
$ cd openshift-ansible
```

Prerequisite check.

```
$ ansible-playbook -i ../inventory.cfg playbooks/prerequisites.yml
```

Provision the cluster.

```
$ ansible-playbook -i ../inventory.cfg playbooks/deploy_cluster.yml
```

### Post install steps

Login to master node using,

```
$ ssh -i ~/.ssh/tf root@console.example.com
```

And to the nodes using,

```
$ ssh -i ~/.ssh/tf root@node-01.example.com
```

Inside master node,

Create admin user.

```
$ htpasswd -cb /etc/origin/master/htpasswd admin <password>
```

Set up GlusterFS as the default storageclass.

```
$ kubectl get storageclass
NAME                PROVISIONER               AGE
glusterfs-storage   kubernetes.io/glusterfs   16m
```

```
$ oc patch storageclass glusterfs-storage -p '{"metadata":{"annotations":{"storageclass.beta.kubernetes.io/is-default-class":"true"}}}'
```

### Deploy Drupal s2i image

Import the image into the openshift registry.

```
$ oc project openshift # all image streams should belong to this namespace
$ oc import-image lakshminp/openshift-drupal:v11 --confirm
```

Add the template either via UI or via cli.

## Day 2 stuff

### Adding new nodes


## Destroying the Cluster

```
$ terraform destroy
```

## CI

## Contact

- [email me](mailto:lakshmi@lakshminp.com?subject=Openshift%20Terraform)
- [lakshminp.com](https://www.lakshminp.com)
- [@lakshminp](https://twitter.com/lakshminp)
