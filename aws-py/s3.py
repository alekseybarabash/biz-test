import boto3
import argparse


parser = argparse.ArgumentParser()
parser.add_argument("-d", "--details", type=str,
                    help="List the objects inside the S3 bucket")
args = parser.parse_args()


s3 = boto3.resource('s3')

if args.details:

    bucket = s3.Bucket(args.details)
    for obj in bucket.objects.all():
        print(obj.key)

else:
    for bucket in s3.buckets.all():
        print(bucket.name)
