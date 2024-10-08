#!/usr/bin/env python3
from sagemaker.inputs import TrainingInput
from sagemaker.xgboost import XGBoost
import sagemaker
from sagemaker import get_execution_role
# Manually specify the IAM role ARN
role = "arn:aws:iam::137360334857:role/AmazonSageMaker-ExecutionRole"


# Define the S3 location of the training data
s3_train_data = 's3://bkt-syed-2024-10-08-06-15-56z/data/train.csv'
sagemaker_session = sagemaker.Session()
# Create an XGBoost estimator object
xgboost_estimator = XGBoost(
    entry_point='train.py',  # Python script for custom training
    framework_version='1.0-1',
    instance_type='ml.m5.xlarge',
    instance_count=1,
    role=role,
    hyperparameters={'max_depth': 5, 'eta': 0.2, 'objective': 'binary:logistic', 'num_round': 100},
    sagemaker_session=sagemaker_session
)

# Start training
xgboost_estimator.fit({'train': TrainingInput(s3_train_data, content_type='text/csv')})
