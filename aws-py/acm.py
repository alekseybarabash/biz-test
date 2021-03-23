import boto3
import pprint
import argparse


pp = pprint.PrettyPrinter(indent=0)

parser = argparse.ArgumentParser()
parser.add_argument("-d", "--details", type=str,
                    help="Describe AWS certificate")
args = parser.parse_args()


client = boto3.client('acm')


if args.details:
    rc = client.describe_certificate(CertificateArn=args.details)
    pp.pprint(rc)

else:
    res = client.list_certificates(CertificateStatuses=['ISSUED'])

    print('Certificates list')
    for r in res['CertificateSummaryList']:
        print(f'{r["CertificateArn"]}')
