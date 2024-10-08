#!/usr/bin/env python3

# train.py
import argparse
import os
import joblib
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

# Parse input arguments
if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # Add hyperparameters as command-line arguments
    parser.add_argument('--n_estimators', type=int, default=100)
    parser.add_argument('--max_depth', type=int, default=None)

    # Define input and output directories
    parser.add_argument('--model-dir', type=str, default=os.environ['SM_MODEL_DIR'])

    args = parser.parse_args()

    # Load dataset
    iris = load_iris()
    X_train, X_test, y_train, y_test = train_test_split(iris.data, iris.target, test_size=0.2)

    # Train model
    model = RandomForestClassifier(n_estimators=args.n_estimators, max_depth=args.max_depth)
    model.fit(X_train, y_train)

    # Save model
    joblib.dump(model, os.path.join(args.model_dir, "model.joblib"))
