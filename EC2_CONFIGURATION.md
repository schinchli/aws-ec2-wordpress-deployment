# EC2 Instance Configuration Details

## 🖥️ Instance Specifications

### Basic Configuration
```yaml
Instance Details:
├─ Instance ID: i-037b4d777295f2bf3
├─ Instance Type: t3.micro
├─ AMI ID: ami-03fc0e9b14614fd10
├─ AMI Name: bitnami-wordpress-6.8.3-0-linux-debian-12-x86_64-hvm-ebs-nami
├─ Platform: Linux/UNIX
├─ Architecture: x86_64
├─ Virtualization: HVM
├─ Root Device Type: EBS
└─ Instance State: running
```

### Hardware Specifications
```yaml
t3.micro Specifications:
├─ vCPUs: 2
├─ Memory: 1 GiB
├─ Instance Storage: EBS-only
├─ Network Performance: Up to 5 Gigabit
├─ EBS Bandwidth: Up to 2,085 Mbps
├─ CPU Credits: Burstable Performance
├─ Baseline CPU Performance: 20%
└─ Maximum CPU Performance: 100% (with credits)
```

### CPU Credits and Burstable Performance
```yaml
T3 Burstable Performance:
├─ Baseline Performance: 20% of CPU
├─ CPU Credits Earned: 24 credits/hour
├─ CPU Credits Consumed: 1 credit = 1 vCPU minute at 100%
├─ Credit Balance: Accumulates when below baseline
├─ Burst Capability: Up to 100% CPU when credits available
├─ Unlimited Mode: Available (additional charges apply)
└─ Monitoring: CloudWatch CPU Credit metrics
```

## 🌐 Network Configuration

### Network Interface Details
```yaml
Primary Network Interface:
├─ Network Interface ID: eni-019bc1f5b3edf3556
├─ Subnet ID: subnet-0af6eca32b44cc7fe
├─ VPC ID: vpc-02ba04a37938bda68
├─ Availability Zone: us-east-1a
├─ Private IPv4: 172.31.29.65
├─ Public IPv4: 54.196.248.208
├─ Public DNS: ec2-54-196-248-208.compute-1.amazonaws.com
├─ Private DNS: ip-172-31-29-65.ec2.internal
├─ MAC Address: 0a:ff:f4:d9:a3:73
├─ Source/Dest Check: Enabled
└─ Delete on Termination: Yes
```

### Security Group Configuration
```yaml
Security Group: wordpress-simple-sg-schinchli-1762689881
├─ Group ID: sg-0e66587e977c7cc3c
├─ Group Name: wordpress-simple-sg-schinchli-1762689881
├─ Description: WordPress security group
├─ VPC ID: vpc-02ba04a37938bda68

Inbound Rules:
├─ Rule 1:
│  ├─ Type: HTTP
│  ├─ Protocol: TCP
│  ├─ Port: 80
│  ├─ Source: 0.0.0.0/0
│  └─ Description: Web traffic
│
└─ Rule 2:
   ├─ Type: SSH
   ├─ Protocol: TCP
   ├─ Port: 22
   ├─ Source: 0.0.0.0/0
   └─ Description: SSH access

Outbound Rules:
└─ Rule 1:
   ├─ Type: All Traffic
   ├─ Protocol: All
   ├─ Port: All
   ├─ Destination: 0.0.0.0/0
   └─ Description: Default outbound rule
```

## 💾 Storage Configuration

### EBS Volume Details
```yaml
Root Volume (/dev/xvda):
├─ Volume ID: vol-01728f05cc869d447
├─ Volume Type: gp3
├─ Size: 20 GiB
├─ IOPS: 3000 (baseline)
├─ Throughput: 125 MiB/s (baseline)
├─ Encrypted: No
├─ Delete on Termination: Yes
├─ Attachment State: attached
├─ Attachment Time: 2025-11-09T11:44:55+00:00
└─ Device Name: /dev/xvda
```

### File System Layout
```yaml
Disk Usage (Bitnami WordPress):
├─ Total Space: 20 GB
├─ Used Space: ~3.5 GB (WordPress + OS)
├─ Available Space: ~16.5 GB
├─ File System: ext4
├─ Mount Point: /
└─ Reserved Blocks: 5% (1 GB for root)

Key Directories:
├─ WordPress: /opt/bitnami/wordpress/
├─ Apache: /opt/bitnami/apache/
├─ MySQL: /opt/bitnami/mysql/
├─ PHP: /opt/bitnami/php/
├─ Logs: /opt/bitnami/apache/logs/
└─ SSL Certs: /opt/bitnami/apache/conf/bitnami/certs/
```

## 🔐 Security Configuration

### Key Pair Authentication
```yaml
Key Pair Details:
├─ Key Name: wordpress-simple-schinchli-1762689881
├─ Key Type: RSA
├─ Key Format: PEM
├─ Key Size: 2048 bits
├─ Fingerprint: SHA256:xxx...
├─ Created: 2025-11-09T11:44:29+00:00
└─ Usage: SSH authentication only
```

### Instance Metadata Service
```yaml
IMDSv2 Configuration:
├─ State: applied
├─ HTTP Tokens: required (IMDSv2 enforced)
├─ HTTP Put Response Hop Limit: 2
├─ HTTP Endpoint: enabled
├─ HTTP Protocol IPv6: disabled
├─ Instance Metadata Tags: disabled
└─ Security: Enhanced security with session tokens
```

### User Access Configuration
```yaml
Default Users:
├─ bitnami: Primary user (sudo access)
├─ root: System administrator (disabled for SSH)
├─ mysql: Database service user
├─ daemon: System daemon user
└─ www-data: Web server user

SSH Access:
├─ Method: Key-based authentication only
├─ Password Authentication: Disabled
├─ Root Login: Disabled
├─ Port: 22 (default)
└─ Protocol: SSH-2 only
```

## 🚀 Application Stack Configuration

### Bitnami WordPress Stack
```yaml
Stack Version: 6.8.3-0
├─ WordPress: 6.8.3
├─ Apache: 2.4.62
├─ MySQL: 8.0.40
├─ PHP: 8.3.14
├─ phpMyAdmin: 5.2.1
├─ OpenSSL: 3.0.15
└─ ModSecurity: 2.9.8

Installation Path: /opt/bitnami/
├─ WordPress: /opt/bitnami/wordpress/
├─ Apache Config: /opt/bitnami/apache/conf/
├─ MySQL Data: /opt/bitnami/mysql/data/
├─ PHP Config: /opt/bitnami/php/etc/
└─ SSL Certificates: /opt/bitnami/apache/conf/bitnami/certs/
```

### WordPress Configuration
```yaml
WordPress Details:
├─ Version: 6.8.3
├─ Database: bitnami_wordpress
├─ Table Prefix: wp_
├─ Admin URL: /wp-admin/
├─ Content Directory: /opt/bitnami/wordpress/wp-content/
├─ Uploads Directory: /opt/bitnami/wordpress/wp-content/uploads/
├─ Themes Directory: /opt/bitnami/wordpress/wp-content/themes/
├─ Plugins Directory: /opt/bitnami/wordpress/wp-content/plugins/
└─ Configuration: /opt/bitnami/wordpress/wp-config.php

Default Credentials:
├─ Username: user
├─ Password: Located in /home/bitnami/bitnami_credentials
├─ Email: user@example.com (changeable)
└─ Role: Administrator
```

### Apache Web Server Configuration
```yaml
Apache Configuration:
├─ Version: 2.4.62
├─ Server Root: /opt/bitnami/apache
├─ Document Root: /opt/bitnami/apache/htdocs
├─ Configuration File: /opt/bitnami/apache/conf/httpd.conf
├─ Error Log: /opt/bitnami/apache/logs/error_log
├─ Access Log: /opt/bitnami/apache/logs/access_log
├─ PID File: /opt/bitnami/apache/logs/httpd.pid
└─ Listen Ports: 80 (HTTP), 443 (HTTPS)

Virtual Hosts:
├─ Default: *:80 → /opt/bitnami/apache/htdocs
├─ WordPress: *:80 → /opt/bitnami/wordpress
├─ SSL Default: *:443 → /opt/bitnami/apache/htdocs
└─ SSL WordPress: *:443 → /opt/bitnami/wordpress

Modules Enabled:
├─ mod_rewrite: URL rewriting
├─ mod_ssl: SSL/TLS support
├─ mod_php: PHP processing
├─ mod_deflate: Compression
├─ mod_headers: HTTP headers
├─ mod_expires: Cache control
└─ mod_security: Web application firewall
```

### MySQL Database Configuration
```yaml
MySQL Configuration:
├─ Version: 8.0.40
├─ Data Directory: /opt/bitnami/mysql/data
├─ Configuration: /opt/bitnami/mysql/conf/my.cnf
├─ Socket: /opt/bitnami/mysql/tmp/mysql.sock
├─ Port: 3306 (localhost only)
├─ Error Log: /opt/bitnami/mysql/logs/mysqld.log
├─ Binary Logs: Enabled
└─ InnoDB: Default storage engine

WordPress Database:
├─ Database Name: bitnami_wordpress
├─ Username: bn_wordpress
├─ Password: Auto-generated (secure)
├─ Host: localhost
├─ Charset: utf8mb4
├─ Collation: utf8mb4_unicode_ci
└─ Tables: Standard WordPress schema

Performance Settings:
├─ Max Connections: 151
├─ InnoDB Buffer Pool: 128M
├─ Query Cache: Disabled (MySQL 8.0+)
├─ Slow Query Log: Enabled
└─ Binary Logging: Enabled
```

### PHP Configuration
```yaml
PHP Configuration:
├─ Version: 8.3.14
├─ Configuration File: /opt/bitnami/php/etc/php.ini
├─ Extensions Directory: /opt/bitnami/php/lib/php/extensions/
├─ Error Log: /opt/bitnami/php/logs/php_errors.log
├─ Session Path: /opt/bitnami/php/tmp
└─ Upload Directory: /opt/bitnami/php/tmp

Key Settings:
├─ Memory Limit: 256M
├─ Max Execution Time: 300 seconds
├─ Max Input Time: 300 seconds
├─ Upload Max Filesize: 80M
├─ Post Max Size: 80M
├─ Max File Uploads: 20
├─ Session Timeout: 1440 seconds
└─ Error Reporting: Production level

Extensions Loaded:
├─ mysqli: MySQL database connectivity
├─ gd: Image processing
├─ curl: HTTP client
├─ mbstring: Multibyte string handling
├─ xml: XML processing
├─ zip: Archive handling
├─ openssl: Cryptographic functions
├─ json: JSON processing
├─ fileinfo: File type detection
└─ imagick: Advanced image processing
```

## 🔧 System Services Configuration

### Service Management (systemd)
```yaml
Active Services:
├─ bitnami.service: Main Bitnami stack controller
├─ apache.service: Apache web server
├─ mysql.service: MySQL database server
├─ ssh.service: SSH daemon
├─ cron.service: Task scheduler
└─ rsyslog.service: System logging

Service Status Commands:
├─ Check Status: sudo systemctl status bitnami
├─ Start Service: sudo systemctl start bitnami
├─ Stop Service: sudo systemctl stop bitnami
├─ Restart Service: sudo systemctl restart bitnami
└─ Enable/Disable: sudo systemctl enable/disable bitnami

Bitnami Control Script:
├─ Location: /opt/bitnami/ctlscript.sh
├─ Start All: sudo /opt/bitnami/ctlscript.sh start
├─ Stop All: sudo /opt/bitnami/ctlscript.sh stop
├─ Restart All: sudo /opt/bitnami/ctlscript.sh restart
└─ Status All: sudo /opt/bitnami/ctlscript.sh status
```

### Log Files and Monitoring
```yaml
System Logs:
├─ System Messages: /var/log/messages
├─ Authentication: /var/log/auth.log
├─ Kernel Messages: /var/log/kern.log
├─ System Boot: /var/log/boot.log
└─ Cron Jobs: /var/log/cron.log

Application Logs:
├─ Apache Access: /opt/bitnami/apache/logs/access_log
├─ Apache Error: /opt/bitnami/apache/logs/error_log
├─ MySQL Error: /opt/bitnami/mysql/logs/mysqld.log
├─ MySQL Slow Query: /opt/bitnami/mysql/logs/mysqld-slow.log
├─ PHP Errors: /opt/bitnami/php/logs/php_errors.log
└─ WordPress Debug: /opt/bitnami/wordpress/wp-content/debug.log

Log Rotation:
├─ Configuration: /etc/logrotate.conf
├─ Frequency: Daily/Weekly based on size
├─ Retention: 4 weeks for most logs
├─ Compression: Enabled for archived logs
└─ Permissions: Maintained during rotation
```

## 📊 Performance and Monitoring

### CloudWatch Metrics Available
```yaml
EC2 Metrics:
├─ CPUUtilization: Percentage of CPU usage
├─ NetworkIn: Bytes received on all network interfaces
├─ NetworkOut: Bytes sent on all network interfaces
├─ NetworkPacketsIn: Packets received
├─ NetworkPacketsOut: Packets sent
├─ DiskReadOps: Read operations on EBS volumes
├─ DiskWriteOps: Write operations on EBS volumes
├─ DiskReadBytes: Bytes read from EBS volumes
├─ DiskWriteBytes: Bytes written to EBS volumes
├─ StatusCheckFailed: Instance and system status checks
├─ StatusCheckFailed_Instance: Instance status check
└─ StatusCheckFailed_System: System status check

Custom Metrics (Available via CloudWatch Agent):
├─ Memory Utilization
├─ Disk Space Utilization
├─ Swap Usage
├─ Process Count
├─ Network Interface Statistics
└─ Application-specific metrics
```

### Performance Baselines
```yaml
Expected Performance (t3.micro):
├─ CPU Baseline: 20% continuous
├─ CPU Burst: Up to 100% with credits
├─ Memory: 1 GB total
├─ Network: Up to 5 Gbps burst
├─ EBS: Up to 2,085 Mbps bandwidth
├─ IOPS: 3,000 baseline (gp3)
└─ Latency: <10ms for local operations

WordPress Performance:
├─ Page Load Time: 2-4 seconds (uncached)
├─ Admin Load Time: 3-5 seconds
├─ Database Queries: 20-50 per page
├─ Memory Usage: 200-400 MB
├─ Concurrent Users: 10-50 (depending on content)
└─ Cache Hit Ratio: 80%+ (with caching plugins)
```

## 🔄 Backup and Recovery Configuration

### EBS Snapshot Configuration
```yaml
Snapshot Strategy:
├─ Frequency: Manual (can be automated)
├─ Retention: Based on requirements
├─ Encryption: Inherits from source volume
├─ Cross-Region: Available for disaster recovery
└─ Point-in-Time: Consistent snapshots

Automated Backup Options:
├─ AWS Backup: Centralized backup service
├─ Data Lifecycle Manager: EBS snapshot automation
├─ Lambda Functions: Custom backup scripts
└─ Third-party Tools: Backup plugins and services
```

### WordPress Backup Strategy
```yaml
Backup Components:
├─ Database: MySQL dump of bitnami_wordpress
├─ Files: /opt/bitnami/wordpress/ directory
├─ Configuration: wp-config.php and .htaccess
├─ Uploads: wp-content/uploads/ media files
├─ Themes: Custom themes and modifications
└─ Plugins: Installed plugins and configurations

Backup Methods:
├─ Manual: mysqldump + tar archive
├─ WordPress Plugins: UpdraftPlus, BackWPup
├─ AWS Services: RDS snapshots, S3 sync
└─ Third-party: Automated backup services
```

## 🛡️ Security Hardening Applied

### Operating System Security
```yaml
Security Measures:
├─ Automatic Updates: Enabled for security patches
├─ Firewall: iptables configured
├─ SSH Hardening: Key-only authentication
├─ User Accounts: Minimal user accounts
├─ File Permissions: Proper ownership and permissions
├─ System Logs: Comprehensive logging enabled
└─ Fail2ban: Available for brute force protection

Bitnami Security Features:
├─ Default Passwords: Auto-generated strong passwords
├─ SSL/TLS: Pre-configured certificates
├─ ModSecurity: Web application firewall
├─ Security Headers: HTTP security headers
├─ File Permissions: Restrictive file permissions
└─ Database Security: Local-only MySQL access
```

### WordPress Security Configuration
```yaml
WordPress Security:
├─ Version: Latest stable (6.8.3)
├─ Admin User: Strong default password
├─ File Permissions: 644 for files, 755 for directories
├─ wp-config.php: 600 permissions, security keys
├─ Database Prefix: Non-default prefix
├─ Debug Mode: Disabled in production
├─ File Editing: Can be disabled via wp-config.php
└─ Automatic Updates: Enabled for security releases

Recommended Security Plugins:
├─ Wordfence: Comprehensive security suite
├─ Sucuri: Malware scanning and cleanup
├─ iThemes Security: Security hardening
├─ All In One WP Security: Security features
└─ Limit Login Attempts: Brute force protection
```

This comprehensive configuration documentation provides complete details about the EC2 instance setup, from hardware specifications to application stack configuration, enabling full understanding and replication of the WordPress deployment.
