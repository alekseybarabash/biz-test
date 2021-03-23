# TERRAFORM install:

# Requirements
- Terraform 0.13 and higher
- Python3

# Download and install terraform:
- Download [terraform](https://www.terraform.io/downloads.html)
- MacOSx install:
```bash
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_darwin_amd64.zip

unzip terraform_0.13.5_darwin_amd64.zip

mv terraform /usr/local/bin/terraform
```
or run brew if installed:
```bash
brew install terraform
```

- Main commands:
```bash
terraform version
terraform init
terraform plan
terraform apply
terraform destroy 
```

# AWS-TF:
- configure [AWS credentials/config](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
```bash
mkdir ~/.aws

cat <<EOF > credentials
[test]
aws_access_key_id=yyyyyyy
aws_secret_access_key=xxxxxxxxx
EOF

cat <<EOF > config
[profile test]
region = eu-central-1
output = json
EOF
```
- if config exists will overwrite

- Create manually S3 backet for Terraform state
- Enter into aws-tf directory and run command:
```bash
terraform init
```
- if no errors, run nexr command:
```bash
terraform plan
```
- if looks as you expect, run:
```bash
terraform apply
```
and watch how your resources are created.

In the end you'll get output with ready to use commands:
- SSH to created VirtualMachine
```bash
ssh -i out/id_rsa ubuntu@ec2-3-120-179-254.eu-central-1.compute.amazonaws.com
```
- HTTP curl via created LoadBalancer to VM nginx
```bash
curl biz-tf-elb-1712701072.eu-central-1.elb.amazonaws.com
```
after run you'll see: `WELCOME TO BIZ-TEST!` 
- HTTPS curl via created LoadBalancer to VM nginx
```bash
curl -k https://biz-tf-elb-1712701072.eu-central-1.elb.amazonaws.com
```
after run you'll see: `WELCOME TO BIZ-TEST!`
- HTTP curl to VM nginx, closed from external
```bash
curl ec2-3-120-179-254.eu-central-1.compute.amazonaws.com
```

- The public and private keys for access to the created VM will be written to the OUT directory,
below is the command how to use them.


# AWS-PY:
# Requirements:
- Installed Python minimal requared version 3.6
- Installed module [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html#installation)

```bash
python3 -m pip install boto3 
```
Python scripts are in the `aws-py` directory. All scripts have a common syntax. 
Launched without parameters, they will display a list of existing objects. 
By running it with the `-d` key and passing the object as a parameter, we will get a detailed description of the object.
Below are some examples.

Example for each program:
- List AWS services:
```bash
python3 vpc.py
```
- Service description in detail:
```bash
python3 vpc.py -d vpc_id
```
