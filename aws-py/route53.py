import boto3
import pprint
import argparse


pp = pprint.PrettyPrinter(indent=0)

parser = argparse.ArgumentParser()
parser.add_argument("-d", "--details", type=str,
                    help="Describe AWS certificate")
args = parser.parse_args()


client = boto3.client('route53')

if args.details:
    rc = client.get_hosted_zone(Id=args.details)
    pp.pprint(rc)

else:
    res = client.list_hosted_zones()

    hz = res["HostedZones"]

    print('Route53 Hosted Zones list')
    for z in hz:
        print(f'{z["Id"]}')
