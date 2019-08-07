#!/bin/bash
#to run this script in terminal: ./deploy/deploy.sh from root

# Make a build that we can copy out to the server (i.e. make a dist.tgz)
npm run build
# Pack up the dist directory (we want one file to copy, not many files)
tar -cvf dist.tgz dist
# Copy the files to the production server
scp -i deploy/kimskeys.pem dist.tgz ubuntu@52.15.102.102:.

# Create an ssh session on the server
# Delete the old dist directory
# Unpack our new dist.tgz
# Start the server
ssh -i deploy/kimskeys.pem ubuntu@52.15.102.102 'rm -rf dist; tar -xvf dist.tgz; sudo kill -9 $(pgrep nodejs); sudo nohup nodejs server.js &'