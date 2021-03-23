import boto3
import argparse


parser = argparse.ArgumentParser()
parser.add_argument("-d", "--details", type=str,
                    help="Describe EC2 instance")
args = parser.parse_args()


ec2 = boto3.resource('ec2')

if args.details:

    ins = ec2.Instance(args.details)
    print(f'         VPC Id: {ins.vpc_id}')
    print(f'          State: {ins.state["Name"]}')
    print(f'           Type: {ins.instance_type} (hypervisor: {ins.hypervisor}  virtualization: {ins.virtualization_type})')
    print(f'            CPU: {ins.architecture} vCores: {ins.cpu_options["CoreCount"]} Threads Per Core: {ins.cpu_options["ThreadsPerCore"]}')
    print(f'    Root device: {ins.root_device_name} ({ins.root_device_type})')
    print(f'     Public DNS: {ins.public_dns_name} ({ins.public_ip_address})')
    print(f'    Private DNS: {ins.private_dns_name} ({ins.private_ip_address})')
    print(f'Security Groups: {ins.security_groups}')

else:
    print('EC2 instances list')
    for i in ec2.instances.all():
        print(f'{i.id}')
