import boto3
import argparse


parser = argparse.ArgumentParser()
parser.add_argument("-d", "--details", type=str,
                    help="Describe VPC")
args = parser.parse_args()


client = boto3.client('ec2')


if args.details:
    vpcs = client.describe_vpcs(VpcIds=[args.details])
    vp = vpcs['Vpcs'][0]
    print(f'     VPC Id: {vp["VpcId"]}')
    print(f'      Owner: {vp["OwnerId"]}')
    print(f'      State: {vp["State"]}')
    print(f'       CIDR: {vp["CidrBlock"]}')
    print(f'       Tags: {vp["Tags"]}')

else:
    vpcs = client.describe_vpcs()

    vp = vpcs['Vpcs']

    print('VPCs list')
    for v in vp:
        print(f'{v["VpcId"]}')
