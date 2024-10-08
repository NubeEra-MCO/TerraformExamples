#!/usr/bin/env python3
import sagemaker
import boto3

# Set the AWS region
region = 'us-west-2'  # Change to your AWS region

# Manually specify the IAM role ARN
role = "arn:aws:iam::137360334857:role/AmazonSageMaker-ExecutionRole"

# Set up SageMaker session
sagemaker_session = sagemaker.Session()

# Optionally, set up a Boto3 session
boto3_session = boto3.Session(region_name=region)

print("SageMaker session and role are set up.")

