#!/bin/bash
set -e

# Configuration
KEY_NAME="wordpress-simple-$(whoami)-$(date +%s)"
SECURITY_GROUP_NAME="wordpress-simple-sg-$(whoami)-$(date +%s)"
INSTANCE_TYPE="t3.micro"
REGION="us-east-1"

echo "🚀 Deploying Simple WordPress on AWS EC2"

# Step 1: Create Key Pair
echo "🔑 Creating EC2 Key Pair..."
aws ec2 create-key-pair \
    --key-name $KEY_NAME \
    --region $REGION \
    --query 'KeyMaterial' \
    --output text > ${KEY_NAME}.pem

chmod 400 ${KEY_NAME}.pem

# Step 2: Create Security Group
echo "🛡️ Creating Security Group..."
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
    --group-name $SECURITY_GROUP_NAME \
    --description "WordPress security group" \
    --region $REGION \
    --query 'GroupId' \
    --output text)

# Add rules
aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $REGION

aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $REGION

# Step 3: Get WordPress AMI (Bitnami WordPress)
echo "🖥️ Finding WordPress AMI..."
AMI_ID=$(aws ec2 describe-images \
    --owners 979382823631 \
    --filters "Name=name,Values=bitnami-wordpress-*" "Name=state,Values=available" \
    --region $REGION \
    --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
    --output text)

echo "✅ Using WordPress AMI: $AMI_ID"

# Step 4: Launch Instance
echo "🚀 Launching WordPress Instance..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP_ID \
    --region $REGION \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WordPress-Simple}]' \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "✅ Instance launched: $INSTANCE_ID"

# Step 5: Wait for running
echo "⏳ Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --region $REGION \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

echo "✅ Instance is running!"

# Step 6: Wait for WordPress to be ready
echo "⏳ Waiting for WordPress to be ready..."
for i in {1..20}; do
    if curl -s -o /dev/null -w "%{http_code}" "http://$PUBLIC_IP" | grep -q "200"; then
        echo "✅ WordPress is ready!"
        break
    fi
    echo "Waiting... ($i/20)"
    sleep 30
done

# Save info
cat > deployment-simple.json << EOF
{
    "instance_id": "$INSTANCE_ID",
    "public_ip": "$PUBLIC_IP",
    "key_name": "$KEY_NAME",
    "security_group_id": "$SECURITY_GROUP_ID",
    "wordpress_url": "http://$PUBLIC_IP",
    "ssh_command": "ssh -i ${KEY_NAME}.pem bitnami@$PUBLIC_IP"
}
EOF

echo ""
echo "🎉 WordPress Deployment Complete!"
echo "=================================="
echo "WordPress URL: http://$PUBLIC_IP"
echo "SSH Access: ssh -i ${KEY_NAME}.pem bitnami@$PUBLIC_IP"
echo ""
echo "📝 Bitnami WordPress Info:"
echo "- Default user: user"
echo "- Get password: sudo cat /home/bitnami/bitnami_credentials"
echo "- Admin URL: http://$PUBLIC_IP/wp-admin"
