# Vagrant & Puppet - Typesafe Stack / Play Framework
This is a quick sample configuration using Vagrant and Puppet to provision an Ubuntu box running a sample Play application.

## Purpose
This repo will help us provision a virtual environment running Ubuntu (Lucid) using Vagrant (and Oracle VirtualBox, behind the scenes). Once we've provisioned and configured our virtual environment, we will use the configuration management tool *Puppet* to configure our box with the following:
* Java
* Scala
* Typesafe Stack / Play! framework
* Git
* And all dependencies…

## Instructions

1. Install Oracle VM VirtualBox (https://www.virtualbox.org/)
2. Install Vagrant (http://vagrantup.com/)
3. Using Git on your workstation clone this repo from the command line
4. From the cloned folder (where the Vagrantfile resides) execute *vagrant up*. This will provision your virtualized environment.
5. Once launched, you should be able to browse to http://localhost:9000 and see our sample Play application (Websocket Chat) running as a web application
