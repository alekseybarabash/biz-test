import boto3
import pprint
import argparse


pp = pprint.PrettyPrinter(indent=0)

parser = argparse.ArgumentParser()
parser.add_argument("-d", "--details", type=str,
                    help="Describe ELB v1")
args = parser.parse_args()


client = boto3.client('elb')


if args.details:

    rc = client.describe_load_balancers(LoadBalancerNames=[args.details])
    elb = rc['LoadBalancerDescriptions'][0]
    lis = elb["ListenerDescriptions"]
    print(f'               Name: {elb["LoadBalancerName"]} (created at {elb["CreatedTime"]})')
    print(f'                DNS: {elb["DNSName"]}')
    print(f'             VPC Id: {elb["VPCId"]}')
    print(f' Availability Zones: {elb["AvailabilityZones"]}')
    print(f'            Subnets: {elb["Subnets"]}')
    print(f'          Instances: {elb["Instances"]}')
    print(f'    Security Groups: {elb["SecurityGroups"]}')
    print(f'       Health Check: {elb["HealthCheck"]}')
    print(f'             Scheme: {elb["Scheme"]}')
    print(f'           Backends: {elb["BackendServerDescriptions"]}')
    print(f'          Listeners: {len(lis)}')
    for li in lis:
        l = li["Listener"]
        print(f'                   : protocol: {l["Protocol"]}  port: {l["LoadBalancerPort"]}  instance proto: {l["InstanceProtocol"]}  instance port: {l["InstancePort"]}')

else:
    rc = client.describe_load_balancers()
    for elb in rc['LoadBalancerDescriptions']:
        print(f'{elb["LoadBalancerName"]}  DNS: {elb["DNSName"]}')
