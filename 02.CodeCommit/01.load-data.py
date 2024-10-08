# pip install scikit-learn --break-system-packages --no-warn-script-location
# pip install pandas --break-system-packages --no-warn-script-location
# python3 01.load-data.py
##########################Loading Data to DataFrame ###################
from sklearn.datasets import load_iris
import pandas as pd

# Load the dataset
iris = load_iris()

# Convert to a DataFrame
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['target'] = iris.target

# Preview the dataset
print( df.head() )
###########################Split Data into CSVs(Train, Test) #######################################
from sklearn.model_selection import train_test_split

# Split the data
train_data, test_data = train_test_split(df, test_size=0.2, random_state=42)

# Save the train and test data as CSV files
train_data.to_csv('train.csv', index=False)
test_data.to_csv('test.csv', index=False)

####################Uploading to S3 Bucket######################################################
# import boto3

# # Initialize S3 client
# s3 = boto3.client('s3')

# # Upload data to S3
# bucket_name = 'bkt-syed-2024-10-08-06-15-56z'
# s3.upload_file('train.csv', bucket_name, 'data/train.csv')
# s3.upload_file('test.csv', bucket_name, 'data/test.csv')
