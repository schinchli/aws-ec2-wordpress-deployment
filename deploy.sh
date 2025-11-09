#!/bin/bash
set -e

# Configuration
KEY_NAME="wordpress-key-$(whoami)-$(date +%s)"
SECURITY_GROUP_NAME="wordpress-sg-$(whoami)-$(date +%s)"
INSTANCE_TYPE="t3.micro"
REGION="us-east-1"

echo "🚀 Deploying WordPress on AWS EC2"
echo "Key Name: $KEY_NAME"
echo "Security Group: $SECURITY_GROUP_NAME"
echo "Instance Type: $INSTANCE_TYPE"
echo "Region: $REGION"

# Step 1: Create Key Pair
echo "🔑 Step 1: Creating EC2 Key Pair..."
aws ec2 create-key-pair \
    --key-name $KEY_NAME \
    --region $REGION \
    --query 'KeyMaterial' \
    --output text > ${KEY_NAME}.pem

chmod 400 ${KEY_NAME}.pem
echo "✅ Key pair created: ${KEY_NAME}.pem"

# Step 2: Create Security Group
echo "🛡️ Step 2: Creating Security Group..."
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
    --group-name $SECURITY_GROUP_NAME \
    --description "Security group for WordPress EC2 instance" \
    --region $REGION \
    --query 'GroupId' \
    --output text)

# Add inbound rules
aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0 \
    --region $REGION

aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0 \
    --region $REGION

aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0 \
    --region $REGION

echo "✅ Security group created: $SECURITY_GROUP_ID"

# Step 3: Get latest Amazon Linux 2023 AMI
echo "🖥️ Step 3: Finding latest Amazon Linux 2023 AMI..."
AMI_ID=$(aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=al2023-ami-*-x86_64" "Name=state,Values=available" \
    --region $REGION \
    --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
    --output text)

echo "✅ Using AMI: $AMI_ID"

# Step 4: Create User Data Script for WordPress Installation
cat > user-data.sh << 'EOF'
#!/bin/bash
yum update -y
yum install -y httpd php php-mysqlnd mariadb-server

# Start and enable services
systemctl start httpd
systemctl enable httpd
systemctl start mariadb
systemctl enable mariadb

# Secure MySQL installation
mysql -e "UPDATE mysql.user SET Password = PASSWORD('wordpress123') WHERE User = 'root'"
mysql -e "DELETE FROM mysql.user WHERE User=''"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
mysql -e "DROP DATABASE IF EXISTS test"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
mysql -e "CREATE DATABASE wordpress"
mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppass123'"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost'"
mysql -e "FLUSH PRIVILEGES"

# Download and install WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Set permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Create WordPress config
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wordpress/' wp-config.php
sed -i 's/username_here/wpuser/' wp-config.php
sed -i 's/password_here/wppass123/' wp-config.php

# Generate WordPress salts
SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
sed -i '/AUTH_KEY/,/NONCE_SALT/d' wp-config.php
echo "$SALTS" >> wp-config.php
echo "define('WP_DEBUG', false);" >> wp-config.php
echo "if ( !defined('ABSPATH') )" >> wp-config.php
echo "    define('ABSPATH', dirname(__FILE__) . '/');" >> wp-config.php
echo "require_once(ABSPATH . 'wp-settings.php');" >> wp-config.php

# Restart Apache
systemctl restart httpd

# Create info file
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
EOF

# Step 5: Launch EC2 Instance
echo "🚀 Step 5: Launching EC2 Instance..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP_ID \
    --user-data file://user-data.sh \
    --region $REGION \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WordPress-Blog}]' \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "✅ Instance launched: $INSTANCE_ID"

# Step 6: Wait for instance to be running
echo "⏳ Step 6: Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --region $REGION \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

echo "✅ Instance is running!"

# Step 7: Wait for WordPress installation
echo "⏳ Step 7: Waiting for WordPress installation (this may take 5-10 minutes)..."
echo "Checking WordPress availability..."

for i in {1..30}; do
    if curl -s -o /dev/null -w "%{http_code}" "http://$PUBLIC_IP" | grep -q "200\|302"; then
        echo "✅ WordPress is ready!"
        break
    fi
    echo "Waiting... ($i/30)"
    sleep 30
done

# Save deployment info
cat > deployment-info.json << EOF
{
    "instance_id": "$INSTANCE_ID",
    "public_ip": "$PUBLIC_IP",
    "key_name": "$KEY_NAME",
    "security_group_id": "$SECURITY_GROUP_ID",
    "wordpress_url": "http://$PUBLIC_IP",
    "admin_url": "http://$PUBLIC_IP/wp-admin",
    "ssh_command": "ssh -i ${KEY_NAME}.pem ec2-user@$PUBLIC_IP",
    "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

# Cleanup
rm -f user-data.sh

echo ""
echo "🎉 WordPress Deployment Complete!"
echo "=================================="
echo "WordPress URL: http://$PUBLIC_IP"
echo "Admin URL: http://$PUBLIC_IP/wp-admin"
echo "SSH Access: ssh -i ${KEY_NAME}.pem ec2-user@$PUBLIC_IP"
echo ""
echo "📝 Next Steps:"
echo "1. Visit your WordPress site: http://$PUBLIC_IP"
echo "2. Complete WordPress setup wizard"
echo "3. Create your admin account"
echo "4. Start blogging!"
echo ""
echo "🔧 Database Info (for reference):"
echo "Database: wordpress"
echo "DB User: wpuser"
echo "DB Password: wppass123"
echo ""
echo "💾 Deployment info saved to: deployment-info.json"
