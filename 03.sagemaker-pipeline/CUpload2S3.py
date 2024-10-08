#!/usr/bin/env python3
####################Uploading to S3 Bucket######################################################
import boto3

# Initialize S3 client
s3 = boto3.client('s3')

# Upload data to S3
bucket_name = 'bkt-syed-2024-10-08-06-15-56z'
s3.upload_file('train.csv', bucket_name, 'data/train.csv')
s3.upload_file('test.csv', bucket_name, 'data/test.csv')

#  aws s3 ls s3://bkt-syed-2024-10-08-06-15-56z/data/