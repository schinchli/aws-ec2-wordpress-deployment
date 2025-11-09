# AWS EC2 WordPress Deployment - Complete Learning Guide

## 🎯 Learning Objectives

By the end of this guide, you will understand:
- What AWS EC2 is and how virtual servers work
- Security groups and network security concepts
- SSH key pairs and secure server access
- Linux server administration basics
- WordPress installation and configuration
- Web server management (Apache, PHP, MySQL)

## 📚 Table of Contents

1. [AWS EC2 Fundamentals](#aws-ec2-fundamentals)
2. [Security Groups & Network Security](#security-groups--network-security)
3. [SSH Key Pairs & Authentication](#ssh-key-pairs--authentication)
4. [Linux Server Administration](#linux-server-administration)
5. [LAMP Stack Components](#lamp-stack-components)
6. [WordPress Installation](#wordpress-installation)
7. [Hands-on Tutorial](#hands-on-tutorial)
8. [Troubleshooting](#troubleshooting)

---

## 🖥️ AWS EC2 Fundamentals

### What is Amazon EC2?
Amazon Elastic Compute Cloud (EC2) provides:
- **Virtual Servers**: Scalable computing capacity in the cloud
- **Multiple Instance Types**: Different CPU, memory, and storage configurations
- **Pay-as-you-go**: Only pay for what you use
- **Global Infrastructure**: Deploy in multiple regions worldwide
- **High Availability**: Built-in redundancy and fault tolerance

### EC2 Core Concepts

#### Instance Types
```
┌─────────────────────────────────────────┐
│            EC2 INSTANCE TYPES           │
├─────────────────────────────────────────┤
│ t3.micro    → 1 vCPU, 1GB RAM (Free)   │
│ t3.small    → 2 vCPU, 2GB RAM          │
│ t3.medium   → 2 vCPU, 4GB RAM          │
│ m5.large    → 2 vCPU, 8GB RAM          │
│ c5.large    → 2 vCPU, 4GB RAM (CPU)    │
│ r5.large    → 2 vCPU, 16GB RAM (Mem)   │
└─────────────────────────────────────────┘
```

#### Amazon Machine Images (AMIs)
Pre-configured server templates:
```yaml
Amazon Linux 2023:
  - Latest Amazon Linux distribution
  - Optimized for AWS
  - Includes AWS CLI and tools
  - Regular security updates

Ubuntu Server:
  - Popular Linux distribution
  - Large community support
  - Extensive package repository

Windows Server:
  - Microsoft Windows Server
  - GUI interface available
  - .NET and IIS support
```

#### Instance Lifecycle
```
┌─────────────────────────────────────────────────────────────────┐
│                    EC2 INSTANCE LIFECYCLE                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Launch → Running → Stop → Stopped → Start → Running           │
│     │                                                           │
│     └─→ Terminate → Terminated (Permanent)                     │
│                                                                 │
│  States:                                                        │
│  • Pending: Starting up                                        │
│  • Running: Active and billable                                │
│  • Stopping: Shutting down                                     │
│  • Stopped: Not running, not billable                          │
│  • Terminated: Permanently deleted                             │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🛡️ Security Groups & Network Security

### What are Security Groups?
Security groups act as virtual firewalls that control traffic to your instances:

```yaml
Security Group Rules:
├─ Inbound Rules: Control incoming traffic
│  ├─ HTTP (Port 80): Web traffic
│  ├─ HTTPS (Port 443): Secure web traffic
│  ├─ SSH (Port 22): Remote server access
│  └─ Custom ports: Application-specific
│
└─ Outbound Rules: Control outgoing traffic
   ├─ All traffic allowed by default
   ├─ Can be restricted for security
   └─ Useful for compliance requirements
```

### Security Group Best Practices

#### 1. **Principle of Least Privilege**
```bash
# Good: Restrict SSH to your IP
Source: 203.0.113.1/32 (Your IP only)

# Bad: Allow SSH from anywhere
Source: 0.0.0.0/0 (Entire internet)
```

#### 2. **Port Configuration**
```yaml
WordPress Security Group:
├─ HTTP (80): 0.0.0.0/0 (Public web access)
├─ HTTPS (443): 0.0.0.0/0 (Secure web access)
├─ SSH (22): YOUR_IP/32 (Admin access only)
└─ MySQL (3306): BLOCKED (Internal only)
```

#### 3. **Security Group Rules**
```bash
# Create security group
aws ec2 create-security-group \
    --group-name wordpress-sg \
    --description "WordPress security group"

# Add HTTP access
aws ec2 authorize-security-group-ingress \
    --group-id sg-12345678 \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

# Add HTTPS access
aws ec2 authorize-security-group-ingress \
    --group-id sg-12345678 \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0

# Add SSH access (replace with your IP)
aws ec2 authorize-security-group-ingress \
    --group-id sg-12345678 \
    --protocol tcp \
    --port 22 \
    --cidr YOUR_IP/32
```

---

## 🔑 SSH Key Pairs & Authentication

### What are SSH Key Pairs?
SSH key pairs provide secure, password-less authentication:

```
┌─────────────────────────────────────────────────────────────────┐
│                    SSH KEY PAIR AUTHENTICATION                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Your Computer                    EC2 Instance                  │
│  ┌─────────────┐                 ┌─────────────┐               │
│  │ Private Key │────────────────▶│ Public Key  │               │
│  │ (Keep Safe) │                 │ (On Server) │               │
│  └─────────────┘                 └─────────────┘               │
│                                                                 │
│  Authentication Process:                                        │
│  1. You initiate SSH connection                                 │
│  2. Server sends challenge                                      │
│  3. Your private key signs challenge                            │
│  4. Server verifies with public key                             │
│  5. Access granted if keys match                                │
└─────────────────────────────────────────────────────────────────┘
```

### SSH Key Management

#### 1. **Creating Key Pairs**
```bash
# AWS CLI method
aws ec2 create-key-pair \
    --key-name my-wordpress-key \
    --query 'KeyMaterial' \
    --output text > my-wordpress-key.pem

# Set proper permissions
chmod 400 my-wordpress-key.pem
```

#### 2. **Connecting to Instances**
```bash
# Basic SSH connection
ssh -i my-wordpress-key.pem ec2-user@PUBLIC_IP

# SSH with verbose output (for troubleshooting)
ssh -v -i my-wordpress-key.pem ec2-user@PUBLIC_IP

# SSH with port forwarding (for databases)
ssh -i my-wordpress-key.pem -L 3306:localhost:3306 ec2-user@PUBLIC_IP
```

#### 3. **Key Security Best Practices**
```yaml
SSH Key Security:
├─ Store private keys securely
├─ Never share private keys
├─ Use different keys for different purposes
├─ Regularly rotate keys
├─ Set proper file permissions (400)
└─ Consider using SSH agent for convenience
```

---

## 🐧 Linux Server Administration

### Basic Linux Commands

#### 1. **File System Navigation**
```bash
# Current directory
pwd

# List files
ls -la

# Change directory
cd /var/www/html

# Create directory
mkdir my-folder

# Remove files/directories
rm file.txt
rm -rf directory/
```

#### 2. **File Operations**
```bash
# View file contents
cat file.txt
less file.txt
tail -f /var/log/httpd/error_log

# Edit files
nano file.txt
vim file.txt

# File permissions
chmod 755 file.txt
chown apache:apache file.txt
```

#### 3. **System Management**
```bash
# Check system status
systemctl status httpd
systemctl status mariadb

# Start/stop services
sudo systemctl start httpd
sudo systemctl stop httpd
sudo systemctl restart httpd

# Enable services at boot
sudo systemctl enable httpd
```

#### 4. **Package Management (Amazon Linux)**
```bash
# Update system
sudo yum update -y

# Install packages
sudo yum install -y httpd php mariadb-server

# Search packages
yum search wordpress

# Remove packages
sudo yum remove package-name
```

---

## 🏗️ LAMP Stack Components

### What is LAMP?
LAMP is a popular web development stack:

```
┌─────────────────────────────────────────────────────────────────┐
│                        LAMP STACK                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  L - Linux (Operating System)                                  │
│  │   ├─ Amazon Linux 2023                                      │
│  │   ├─ File system and kernel                                 │
│  │   └─ System services and security                           │
│  │                                                             │
│  A - Apache (Web Server)                                       │
│  │   ├─ Serves web pages to browsers                           │
│  │   ├─ Handles HTTP/HTTPS requests                            │
│  │   └─ Manages virtual hosts and SSL                          │
│  │                                                             │
│  M - MySQL/MariaDB (Database)                                  │
│  │   ├─ Stores WordPress content                               │
│  │   ├─ User accounts and settings                             │
│  │   └─ Posts, pages, and media                                │
│  │                                                             │
│  P - PHP (Programming Language)                                │
│      ├─ Processes WordPress code                               │
│      ├─ Connects to database                                   │
│      └─ Generates dynamic web pages                            │
└─────────────────────────────────────────────────────────────────┘
```

### Component Installation and Configuration

#### 1. **Apache Web Server**
```bash
# Install Apache
sudo yum install -y httpd

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Check Apache status
sudo systemctl status httpd

# Apache configuration files
/etc/httpd/conf/httpd.conf          # Main config
/var/www/html/                      # Web root
/var/log/httpd/                     # Log files
```

#### 2. **PHP Processing**
```bash
# Install PHP and extensions
sudo yum install -y php php-mysqlnd php-gd php-xml php-mbstring

# Check PHP version
php --version

# Create PHP info page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

# PHP configuration
/etc/php.ini                        # Main PHP config
```

#### 3. **MySQL/MariaDB Database**
```bash
# Install MariaDB
sudo yum install -y mariadb-server

# Start and enable MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure installation
sudo mysql_secure_installation

# Connect to database
mysql -u root -p
```

---

## 📝 WordPress Installation

### WordPress Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    WORDPRESS ARCHITECTURE                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Browser Request                                                │
│       │                                                         │
│       ▼                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐        │
│  │   Apache    │───▶│     PHP     │───▶│   MySQL     │        │
│  │ Web Server  │    │ WordPress   │    │  Database   │        │
│  │             │◀───│   Engine    │◀───│             │        │
│  │ Port 80/443 │    │             │    │ Port 3306   │        │
│  └─────────────┘    └─────────────┘    └─────────────┘        │
│                                                                 │
│  WordPress Files:                                               │
│  ├─ wp-config.php (Database connection)                        │
│  ├─ wp-content/ (Themes, plugins, uploads)                     │
│  ├─ wp-admin/ (Admin interface)                                 │
│  └─ wp-includes/ (Core WordPress files)                        │
└─────────────────────────────────────────────────────────────────┘
```

### Installation Process

#### 1. **Download WordPress**
```bash
# Navigate to web root
cd /var/www/html

# Download latest WordPress
wget https://wordpress.org/latest.tar.gz

# Extract files
tar -xzf latest.tar.gz

# Move files to web root
cp -r wordpress/* .

# Clean up
rm -rf wordpress latest.tar.gz

# Set permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
```

#### 2. **Database Setup**
```sql
-- Connect to MySQL
mysql -u root -p

-- Create WordPress database
CREATE DATABASE wordpress;

-- Create WordPress user
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'secure_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- Exit MySQL
EXIT;
```

#### 3. **WordPress Configuration**
```bash
# Copy sample config
cp wp-config-sample.php wp-config.php

# Edit configuration (replace with your values)
sed -i 's/database_name_here/wordpress/' wp-config.php
sed -i 's/username_here/wpuser/' wp-config.php
sed -i 's/password_here/secure_password/' wp-config.php

# Generate security keys
curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
```

---

## 🛠️ Hands-on Tutorial

### Step-by-Step Deployment

#### Phase 1: AWS Infrastructure Setup
```bash
# 1. Create key pair
aws ec2 create-key-pair \
    --key-name wordpress-key \
    --query 'KeyMaterial' \
    --output text > wordpress-key.pem

chmod 400 wordpress-key.pem

# 2. Create security group
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
    --group-name wordpress-sg \
    --description "WordPress security group" \
    --query 'GroupId' \
    --output text)

# 3. Add security rules
aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp --port 443 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-id $SECURITY_GROUP_ID \
    --protocol tcp --port 22 --cidr 0.0.0.0/0
```

#### Phase 2: EC2 Instance Launch
```bash
# 1. Get latest Amazon Linux AMI
AMI_ID=$(aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=al2023-ami-*-x86_64" \
    --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
    --output text)

# 2. Launch instance
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type t3.micro \
    --key-name wordpress-key \
    --security-group-ids $SECURITY_GROUP_ID \
    --user-data file://user-data.sh \
    --query 'Instances[0].InstanceId' \
    --output text)

# 3. Wait for instance to be running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
```

#### Phase 3: WordPress Setup
The user-data script automatically:
1. Updates the system
2. Installs LAMP stack components
3. Configures MySQL database
4. Downloads and configures WordPress
5. Sets proper permissions
6. Starts all services

#### Phase 4: Access and Configuration
```bash
# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

# Access WordPress
echo "WordPress URL: http://$PUBLIC_IP"
echo "Admin URL: http://$PUBLIC_IP/wp-admin"

# SSH access
ssh -i wordpress-key.pem ec2-user@$PUBLIC_IP
```

---

## 🔧 Troubleshooting Guide

### Common Issues and Solutions

#### 1. **WordPress Not Loading**
```bash
# Check Apache status
sudo systemctl status httpd

# Check Apache logs
sudo tail -f /var/log/httpd/error_log

# Restart Apache
sudo systemctl restart httpd

# Check file permissions
ls -la /var/www/html/
```

#### 2. **Database Connection Error**
```bash
# Check MariaDB status
sudo systemctl status mariadb

# Test database connection
mysql -u wpuser -p wordpress

# Check wp-config.php settings
grep -E "DB_NAME|DB_USER|DB_PASSWORD" /var/www/html/wp-config.php
```

#### 3. **SSH Connection Issues**
```bash
# Check key permissions
ls -la wordpress-key.pem
# Should show: -r-------- (400 permissions)

# Verbose SSH connection
ssh -v -i wordpress-key.pem ec2-user@PUBLIC_IP

# Check security group rules
aws ec2 describe-security-groups --group-ids $SECURITY_GROUP_ID
```

#### 4. **Performance Issues**
```bash
# Check system resources
top
free -h
df -h

# Check Apache processes
ps aux | grep httpd

# Monitor logs in real-time
sudo tail -f /var/log/httpd/access_log
```

### Debugging Commands
```bash
# System information
uname -a
cat /etc/os-release

# Network connectivity
ping google.com
curl -I http://localhost

# Service status
systemctl list-units --failed
journalctl -u httpd -f

# File system
find /var/www/html -type f -name "*.php" | head -10
```

---

## 📈 Performance Optimization

### WordPress Performance Tips

#### 1. **Caching**
```bash
# Install caching plugin (via WordPress admin)
# Recommended: W3 Total Cache, WP Rocket

# Enable Apache mod_expires
sudo nano /etc/httpd/conf/httpd.conf
# Add: LoadModule expires_module modules/mod_expires.so
```

#### 2. **Database Optimization**
```sql
-- Optimize WordPress database
mysql -u wpuser -p wordpress

-- Clean up revisions
DELETE FROM wp_posts WHERE post_type = 'revision';

-- Optimize tables
OPTIMIZE TABLE wp_posts, wp_postmeta, wp_options;
```

#### 3. **Security Hardening**
```bash
# Hide WordPress version
echo "remove_action('wp_head', 'wp_generator');" >> /var/www/html/wp-config.php

# Disable file editing
echo "define('DISALLOW_FILE_EDIT', true);" >> /var/www/html/wp-config.php

# Limit login attempts (install plugin)
# Recommended: Wordfence, Limit Login Attempts
```

---

## 💰 Cost Management

### EC2 Cost Factors
```yaml
Instance Costs:
├─ t3.micro: $0.0104/hour (~$7.50/month)
├─ t3.small: $0.0208/hour (~$15/month)
└─ t3.medium: $0.0416/hour (~$30/month)

Storage Costs:
├─ EBS gp3: $0.08/GB/month
├─ EBS gp2: $0.10/GB/month
└─ Snapshots: $0.05/GB/month

Data Transfer:
├─ First 1GB/month: Free
├─ Next 10TB/month: $0.09/GB
└─ CloudFront: Can reduce costs
```

### Cost Optimization Tips
1. **Use Free Tier**: t3.micro for 750 hours/month
2. **Stop When Not Needed**: Stop instances during downtime
3. **Right-Size Instances**: Monitor and adjust instance types
4. **Use Reserved Instances**: For long-term workloads
5. **Monitor Usage**: Set up billing alerts

---

## 🎓 Learning Outcomes

After completing this tutorial, you will have learned:

### ✅ **AWS EC2 Mastery**
- ✅ EC2 instance types and selection
- ✅ AMI selection and customization
- ✅ Instance lifecycle management
- ✅ Cost optimization strategies

### ✅ **Network Security**
- ✅ Security group configuration
- ✅ Firewall rules and best practices
- ✅ SSH key pair management
- ✅ Network troubleshooting

### ✅ **Linux Administration**
- ✅ Basic Linux commands and navigation
- ✅ System service management
- ✅ File permissions and ownership
- ✅ Package management with yum

### ✅ **Web Server Management**
- ✅ LAMP stack installation and configuration
- ✅ Apache web server management
- ✅ PHP configuration and optimization
- ✅ MySQL database administration

### ✅ **WordPress Expertise**
- ✅ WordPress installation and configuration
- ✅ Database setup and management
- ✅ Security best practices
- ✅ Performance optimization

---

## 🔗 Additional Resources

### Official Documentation
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/latest/userguide/)
- [WordPress Codex](https://codex.wordpress.org/)
- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)
- [MariaDB Knowledge Base](https://mariadb.com/kb/en/)

### Community Resources
- [AWS re:Post](https://repost.aws/)
- [WordPress Support Forums](https://wordpress.org/support/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/amazon-ec2)

### Security Resources
- [AWS Security Best Practices](https://aws.amazon.com/security/security-resources/)
- [WordPress Security Guide](https://wordpress.org/support/article/hardening-wordpress/)
- [OWASP Web Security](https://owasp.org/www-project-top-ten/)

---

**🎉 Congratulations!** You now have comprehensive knowledge of AWS EC2 and WordPress deployment. You can deploy, manage, and optimize WordPress websites on AWS infrastructure with confidence!
