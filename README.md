# Deploy EC2 with WordPress CMS

> **Complete hands-on tutorial for deploying WordPress on AWS EC2 - Learn cloud computing by building a production-ready blog!**

## 🎯 What You'll Learn

- **EC2 Instance Management** - Launch, configure, and manage virtual servers
- **Security Groups** - Configure firewall rules and network security
- **SSH Key Pairs** - Secure server access and authentication
- **Linux Administration** - Basic server management and commands
- **WordPress Installation** - Complete CMS setup and configuration
- **Domain & SSL** - Custom domain setup with HTTPS encryption

## 🎉 Live WordPress Blog

**WordPress URL**: http://54.196.248.208
**Admin URL**: http://54.196.248.208/wp-admin

### 🔑 Access Information
- **SSH**: `ssh -i wordpress-simple-schinchli-1762689881.pem bitnami@54.196.248.208`
- **WordPress Admin**: Get password with `sudo cat /home/bitnami/bitnami_credentials`
- **Default User**: user

## 🚀 Quick Deploy

```bash
# Clone and deploy
cd "Deploying EC2 with WordPress CMS"
./deploy-simple.sh
```

## 📋 What the Script Does

1. ✅ Creates EC2 key pair for secure access
2. ✅ Configures security group with HTTP/HTTPS/SSH access
3. ✅ Launches EC2 instance with WordPress AMI
4. ✅ Waits for instance to be ready
5. ✅ Provides WordPress admin URL and credentials

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    EC2 WORDPRESS ARCHITECTURE                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Internet                                                       │
│       │                                                         │
│       ▼                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐        │
│  │ Security    │───▶│ EC2         │───▶│ WordPress   │        │
│  │ Group       │    │ Instance    │    │ CMS         │        │
│  │ (Firewall)  │◀───│ (t3.micro)  │◀───│ + MySQL     │        │
│  │ HTTP/HTTPS  │    │ Amazon      │    │ + Apache    │        │
│  │ SSH         │    │ Linux 2023  │    │ + PHP       │        │
│  └─────────────┘    └─────────────┘    └─────────────┘        │
└─────────────────────────────────────────────────────────────────┘
```

## 🔧 Prerequisites

- AWS CLI configured with appropriate permissions
- SSH client (built into macOS/Linux)

## 💰 Cost

- **t3.micro**: Free tier eligible (750 hours/month)
- **EBS Storage**: 30GB free tier
- **Data Transfer**: 15GB free tier
- **Estimated Cost**: $0-8/month depending on usage

## 🎓 Learning Path

1. **Deploy** - Run the script and see WordPress launch
2. **Explore** - Access your blog and admin panel
3. **Learn** - Understand EC2, security groups, and WordPress
4. **Customize** - Add content, themes, and plugins

## 📚 Step-by-Step Guide

### Phase 1: Understanding EC2
- What is Amazon EC2 and virtual servers
- Instance types and sizing
- Amazon Machine Images (AMIs)
- Key pairs and security

### Phase 2: Network Security
- Security groups as virtual firewalls
- Inbound and outbound rules
- Port configuration (80, 443, 22)
- Best security practices

### Phase 3: WordPress Setup
- LAMP stack components
- WordPress installation process
- Database configuration
- Admin user creation

### Phase 4: Going Live
- Public IP and DNS
- Domain name setup (optional)
- SSL certificate installation
- Performance optimization

## 🔒 Security Features

- ✅ **SSH Key Authentication** - No password-based access
- ✅ **Security Group Rules** - Restricted port access
- ✅ **WordPress Security** - Latest version with security updates
- ✅ **Regular Backups** - Automated backup recommendations

## 🛠️ Management Commands

```bash
# Connect to your instance
ssh -i your-key.pem ec2-user@your-instance-ip

# Check WordPress status
sudo systemctl status httpd

# View WordPress logs
sudo tail -f /var/log/httpd/error_log

# Restart web server
sudo systemctl restart httpd
```

## 📈 Next Steps

1. **Content Creation** - Add posts, pages, and media
2. **Theme Customization** - Install and customize themes
3. **Plugin Installation** - Add functionality with plugins
4. **Performance** - Optimize for speed and SEO
5. **Backup Strategy** - Implement regular backups
6. **Monitoring** - Set up CloudWatch monitoring

## 📚 Additional Resources

- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/latest/userguide/)
- [WordPress Documentation](https://wordpress.org/documentation/)
- [AWS Security Best Practices](https://aws.amazon.com/security/security-resources/)

---

**🎉 Ready to launch your WordPress blog on AWS? Run `./deploy.sh` and start blogging!**
