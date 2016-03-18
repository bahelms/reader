#!/bin/bash

# Deploy phoenix 
# eb deploy reader-prod

# Update front end
cd front_end
ENV=prod webpack
aws s3 mv build/bundle.js s3://the-reader/
aws s3 mv build/index.html s3://the-reader/
