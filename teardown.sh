#!/bin/bash
set -e

DEPLOYMENT_FILE=${1:-"deployment-simple.json"}

if [ ! -f "$DEPLOYMENT_FILE" ]; then
    echo "❌ Deployment file not found: $DEPLOYMENT_FILE"
    exit 1
fi

INSTANCE_ID=$(jq -r '.instance_id' $DEPLOYMENT_FILE)
SECURITY_GROUP_ID=$(jq -r '.security_group_id' $DEPLOYMENT_FILE)
KEY_NAME=$(jq -r '.key_name' $DEPLOYMENT_FILE)

echo "🧹 Cleaning up WordPress deployment"
echo "Instance: $INSTANCE_ID"
echo "Security Group: $SECURITY_GROUP_ID"
echo "Key: $KEY_NAME"

# Terminate instance
echo "🗑️ Terminating EC2 instance..."
aws ec2 terminate-instances --instance-ids $INSTANCE_ID --region us-east-1

# Wait for termination
echo "⏳ Waiting for instance termination..."
aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID --region us-east-1

# Delete security group
echo "🛡️ Deleting security group..."
aws ec2 delete-security-group --group-id $SECURITY_GROUP_ID --region us-east-1

# Delete key pair
echo "🔑 Deleting key pair..."
aws ec2 delete-key-pair --key-name $KEY_NAME --region us-east-1

# Remove local files
rm -f ${KEY_NAME}.pem $DEPLOYMENT_FILE

echo "✅ Cleanup complete!"
