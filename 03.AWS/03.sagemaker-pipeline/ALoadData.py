#!/usr/bin/env python3
from sklearn.datasets import load_iris
import pandas as pd

# Load the dataset
iris = load_iris()

# Convert to a DataFrame
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['target'] = iris.target

# Preview the dataset
print( df.head() )
# aws s3 ls s3://bkt-syed-2024-10-08-06-15-56z/data/train.csv