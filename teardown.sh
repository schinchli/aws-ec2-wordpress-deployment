#!/bin/bash
set -e

if [ ! -f "deployment.json" ]; then
    echo "❌ No deployment.json found"
    exit 1
fi

REGION=$(jq -r '.region' deployment.json)
INSTANCE_ID=$(jq -r '.instance_id' deployment.json)
SG_ID=$(jq -r '.security_group_id' deployment.json)
KEY_NAME=$(jq -r '.key_name' deployment.json)

echo "🧹 Cleaning up deployment in $REGION"

# Terminate instance
aws ec2 terminate-instances --instance-ids $INSTANCE_ID --region $REGION
aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID --region $REGION

# Delete security group
aws ec2 delete-security-group --group-id $SG_ID --region $REGION

# Delete key pair
aws ec2 delete-key-pair --key-name $KEY_NAME --region $REGION

# Clean up files
rm -f ${KEY_NAME}.pem deployment.json

echo "✅ Cleanup complete!"
