#!/bin/bash
set -e

# Configuration
REGION=${1:-"us-west-2"}
KEY_NAME="wordpress-$(whoami)-$(date +%s)"
SG_NAME="wordpress-sg-$(whoami)-$(date +%s)"
INSTANCE_TYPE="t3.micro"

echo "🚀 Deploying WordPress on Amazon EC2"
echo "Region: $REGION"

# Create key pair
echo "🔑 Creating SSH key pair..."
aws ec2 create-key-pair \
    --key-name $KEY_NAME \
    --region $REGION \
    --query 'KeyMaterial' \
    --output text > ${KEY_NAME}.pem
chmod 400 ${KEY_NAME}.pem

# Create security group
echo "🛡️ Creating security group..."
SG_ID=$(aws ec2 create-security-group \
    --group-name $SG_NAME \
    --description "WordPress security group" \
    --region $REGION \
    --query 'GroupId' \
    --output text)

# Add security rules
aws ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp --port 80 --cidr 0.0.0.0/0 \
    --region $REGION

aws ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp --port 22 --cidr 0.0.0.0/0 \
    --region $REGION

# Get WordPress AMI
echo "🖥️ Finding WordPress AMI..."
AMI_ID=$(aws ec2 describe-images \
    --owners 979382823631 \
    --filters "Name=name,Values=bitnami-wordpress-*" "Name=state,Values=available" \
    --region $REGION \
    --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
    --output text)

# Launch instance
echo "🚀 Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SG_ID \
    --region $REGION \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WordPress}]' \
    --query 'Instances[0].InstanceId' \
    --output text)

# Wait for running state
echo "⏳ Waiting for instance..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --region $REGION \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

# Wait for WordPress
echo "⏳ Waiting for WordPress..."
for i in {1..20}; do
    if curl -s -o /dev/null -w "%{http_code}" "http://$PUBLIC_IP" | grep -q "200"; then
        break
    fi
    sleep 30
done

# Save deployment info
cat > deployment.json << EOF
{
    "region": "$REGION",
    "instance_id": "$INSTANCE_ID",
    "public_ip": "$PUBLIC_IP",
    "key_name": "$KEY_NAME",
    "security_group_id": "$SG_ID",
    "wordpress_url": "http://$PUBLIC_IP",
    "ssh_command": "ssh -i ${KEY_NAME}.pem bitnami@$PUBLIC_IP"
}
EOF

echo ""
echo "✅ WordPress Deployed Successfully!"
echo "Region: $REGION"
echo "WordPress URL: http://$PUBLIC_IP"
echo "SSH: ssh -i ${KEY_NAME}.pem bitnami@$PUBLIC_IP"
echo "Admin Password: sudo cat /home/bitnami/bitnami_credentials"
