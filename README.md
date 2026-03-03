# GratitudeApp

1. Jenkins Installation steps 



2. connect Jenkins to GIT HUB stesp 

[ec2-user@ip-172-31-42-29 ~]$ sudo yum update -y
sudo yum install git -y
git --version
Last metadata expiration check: 0:02:58 ago on Tue Mar  3 03:12:05 2026.
Dependencies resolved.
Nothing to do.
Complete!
Last metadata expiration check: 0:02:59 ago on Tue Mar  3 03:12:05 2026.
Package git-2.50.1-1.amzn2023.0.1.x86_64 is already installed.
Dependencies resolved.
Nothing to do.
Complete!
git version 2.50.1
[ec2-user@ip-172-31-42-29 ~]$ ssh-keygen -t ed25519 -C "vijay.kankane@gmail.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/ec2-user/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ec2-user/.ssh/id_ed25519
Your public key has been saved in /home/ec2-user/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:jwiIQW0Iz8lZvsDGzw1HqHxgUzSD7bsvP7KcLBZlaL8 vijay.kankane@gmail.com
The key's randomart image is:
+--[ED25519 256]--+
|o.o=*..          |
|.B=Bo+           |
|.o%*o .          |
| +====           |
|...==.. S        |
|  . o. . o       |
|   . o. . .      |
|  ooE..          |
| . .=*o.         |
+----[SHA256]-----+
[ec2-user@ip-172-31-42-29 ~]$ cat ~/.ssh/id_ed25519.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUcqFAF3NFThLBfIiNimnLjve87DCV30ZNBY5Fp+6DI vijay.kankane@gmail.com

Go to git hub setting then ass this key and check with ssh -T command below

[ec2-user@ip-172-31-42-29 ~]$ ssh -T git@github.com
Hi vijaykankane! You've successfully authenticated, but GitHub does not provide shell access.
[ec2-user@ip-172-31-42-29 ~]$



git clone repo and go to workingApp branch 

/home/ubuntu/GratitudeApp-vijay

Cleaning the repos 

 sh scripts/repoCleanup.sh


Creating the repo

sh scripts/repoCreation.sh

image build and push to ECR 

 bash scripts/build-and-push-ecr.sh v1.0.0 vijay
 bash scripts/build-push-client-server.sh v1.0.0 vijay
