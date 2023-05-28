
This repository holds example to be executed on a local machine to create Nomad deployment of NGINX that will update it's configuration from consul.

> !!!IMPORTANT!!!  This code was only tested on MAC with M1 processor.

### Prerequisites:
* Vagrant
* Nomad
* Docker
* envsubst

&nbsp;
### Usage:
#### Initiation
To start the local preconfigured environment run:
```commandline
vagrant up
```

&nbsp;
#### Progress verification
In order to check the progress of update in nomad - run: 
```commandline
nomad status nginx | grep running
```
Here you need to observe the last command to know when the change was performed.
.

&nbsp;
#### Current version verification
To check what is the current version of the nginx configuration that is running:
```commandline
docker ps -a | grep nginx | sed 's/.* \([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*:[0-9]*\).*/\1/' | xargs -I {} -n 1 curl {}
``` 

to check 