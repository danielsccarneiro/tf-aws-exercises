## Terraform AWS Scenarios

## Description
This Terraform project does the following:

#### Networking
  * Configures AWS Provider
  * Creates a VPC
  * Configures inbound SSH from VPC security_group
  * Configures default security_group
  * Creates Internet Gateway
  * Creates Subnets across 3 Availability Zones, Public and DMZ subnets.

#### EC2 Instances
  * Generates RSA Keys and Uploads to IAM Users and EC2 instances.
  * Generates ec2 instances across the Availability Zones and Subnets



## Pre-Requisites

### AWS
Sign up for a free AWS account: [Link](https://portal.aws.amazon.com/billing/signup#/start)
Create a new IAM User: [Link](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
  * Select Programmatic access below and enter your user details.
  * Click next and select the admin group.
  * Continue with the steps until you reach the Create User section and confirm the user has been
    created. Once the user is created you will get an Access key ID and Secret access key. Store
    these in a safe location as you will need these later.

### Terraform
Download and install Terraform from Hashicorp: [Link](https://www.terraform.io/downloads.html)
* Add the binary to your PATH
* Run `terraform version`

### Gitlab
Register for a free Gitlab account: [Link](https://gitlab.com/users/sign_up)
* After registration is completed, click on New Project.
* Project Slug: contino-tf-exercise
* Visibility Level: Private
* Clone the empty repository to your local machine.
```
git clone https://gitlab.com/<your_username>
/contino-tf-exercise.git
cd contino-tf-exercise
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```
### Terraform Cloud

Sign up for a free account with Terraform Cloud: [Link](https://app.terraform.io/signup/account?utm_source=terraform_io_download)
Add the Gitlab VCS provider: [Link](https://www.terraform.io/docs/cloud/vcs/gitlab-com.html)
*   Once the VCS provider has been setup, create a new workspace.
*  Click on New Workspace
*  Click on Version control workflow
*  Click on Gitlab.com
*  Select the contino-tf-exercise repository.
*  Click on Create workspace
*  Once the workspace has been created, click on Variables tab.
*  Add the following variables under the Environment Variables section:
*  AWS
  *  Key: AWS_ACCESS_KEY_ID
    *  Value: Access Key
  *  Key: AWS_SECRET_ACCESS_KEY
    *  Value: Secret Access Key

## Deployment Process

Configure Gitlab repo and Terraform Cloud Workspaces.
Ensure AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables are set. See IAM User instructions under AWS pre-requisites.

Review variables.tf file and update values if required.

  * AWS_REGION - default (ap-southeast-2)
  * AWS_AMI - default (Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-0210560cedcb09f07 (64-bit x86))
  * AWS_AZ - Availability Zones (default uses ap-southeast-2 AZ's)
  * AWS_TAGS - Map used for naming EC2 instances
  * AWS_SUBNETS - Subnet as required
  * instance_type - default (t3.micro
  * key_name - if you want to be fancy

### EC2 Instances

These are split into individual .tf files, this isn't ideal but if modifications or additional EC2 instances are required; generate new ones.
Ensure resource names are unique.
Improvement, single EC2 instance .TF file that iterates through a input list and creates as many EC2 instances as there are items in list?

## Extras:

You can either code or explain how the following could be accomplished:

1. CI/CD pipeline for deployment to a Terraform Cloud workspace.

Source Control (Gitlab, CodeCommit), Trigger > AWS CodePipeline > CodeBuild (Terraform validate(?)) > If valid -> CodeDeploy -> Push to Terraform Cloud

2. Any tests to check for success or failure of the pipeline.

Authentication validation
EC2 instance ID queries after build against ID's output during build?

AWS Config exports and comparison to Terraform Outputs (not sure how this would be achieved)
ie VPC config dump, compare subnets to AWS_SUBNET variables etc?
