Web service demo
================

This repo contains a set of Chef recipes that, in combination with Vagrant, allows to deploy a messaging web service built with Python+Flask+MongoDB. The local deployment vagrantfile deploys the messaging service over a local virtual machine, whiche the aws deployment vagrantfile deploys the service over an AWS EC2 instance in the matter of minutes.

## clone

```
git clone https://github.com/gonzalomcruz/tallerUPM.git --recursive
```

## local deployment

```
cd vagrant_dev
vagrant up
```

## aws deployment (production ready)

```
cd vagrant_aws
vagrant up --provider=aws
```
