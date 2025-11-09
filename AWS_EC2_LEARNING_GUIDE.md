# Learn Amazon EC2 Fast - WordPress Tutorial

## 🎯 Learn AWS in 30 Minutes

**Goal**: Understand Amazon EC2 by deploying WordPress

## 📚 Quick Learning Path

### 1. What is Amazon EC2? (5 minutes)

**Simple Answer**: Rent computers in the cloud instead of buying them.

```
Your Computer at Home    vs    Amazon EC2 in Cloud
├─ Buy for $1000              ├─ Rent for $9/month
├─ Maintain yourself          ├─ Amazon maintains it
├─ Limited to your location   ├─ Access from anywhere
└─ Fixed specifications       └─ Change size anytime
```

**Key Benefits**:
- Pay only when running
- Scale up/down instantly
- No hardware maintenance
- Global availability

### 2. EC2 Instance Types (3 minutes)

```yaml
t3.micro (What we use):
├─ 1 GB RAM
├─ 2 vCPUs
├─ $7.59/month
└─ Perfect for small websites

Other sizes:
├─ t3.small: 2GB RAM, $15/month
├─ t3.medium: 4GB RAM, $30/month
└─ Scale up as you grow
```

### 3. Security Groups = Cloud Firewall (5 minutes)

**Think of it as**: Bouncer at a club door

```yaml
Security Group Rules:
├─ Port 80 (HTTP): Let website visitors in
├─ Port 22 (SSH): Let admin (you) in
└─ Block everything else
```

**Why Important**: Protects your server from hackers

### 4. SSH Keys = Secure Login (5 minutes)

**Instead of passwords**, use key pairs:

```
Your Computer          Amazon EC2
├─ Private Key    →    ├─ Public Key
└─ Keep secret         └─ Matches your key
```

**Benefits**:
- More secure than passwords
- Can't be guessed or stolen
- Industry standard

### 5. WordPress on EC2 (5 minutes)

**What happens when you deploy**:

```
1. Launch EC2 instance (virtual computer)
2. Install Linux operating system
3. Install web server (Apache)
4. Install database (MySQL)
5. Install PHP (runs WordPress)
6. Install WordPress
7. Configure everything to work together
```

**Result**: Professional WordPress blog in the cloud

### 6. LAMP Stack Explained (3 minutes)

**LAMP** = The software that runs WordPress

```
L - Linux (Operating System)
A - Apache (Web Server)
M - MySQL (Database)
P - PHP (Programming Language)
```

**How it works**:
1. Visitor requests your blog
2. Apache receives the request
3. PHP processes WordPress code
4. MySQL provides the content
5. Apache sends webpage back

### 7. Cost Management (4 minutes)

**Free Tier (First 12 months)**:
- 750 hours/month EC2 (24/7 coverage)
- 30GB storage
- 15GB data transfer
- **Total: $0**

**After Free Tier**:
- EC2 t3.micro: $7.59/month
- Storage 20GB: $1.60/month
- Data transfer: $0.36/month
- **Total: $9.55/month**

**Cost Optimization Tips**:
- Stop instance when not needed
- Use Reserved Instances for 40% savings
- Monitor usage with AWS Cost Explorer

## 🚀 Hands-On Tutorial

### Step 1: Deploy WordPress (5 minutes)

```bash
# Clone the tutorial
git clone https://github.com/schinchli/aws-ec2-wordpress-deployment.git
cd aws-ec2-wordpress-deployment

# Deploy to AWS
./deploy-simple.sh
```

**What the script does**:
1. Creates SSH key pair
2. Creates security group
3. Launches EC2 instance
4. Installs WordPress automatically
5. Gives you the website URL

### Step 2: Access Your Blog (2 minutes)

1. Visit the URL provided
2. See your live WordPress blog
3. Go to `/wp-admin` for admin panel
4. Login with provided credentials

### Step 3: Customize WordPress (10 minutes)

1. **Add content**: Create your first blog post
2. **Change theme**: Make it look professional
3. **Install plugins**: Add functionality
4. **Configure settings**: Set site title and description

### Step 4: Understand What You Built (10 minutes)

**SSH into your server**:
```bash
ssh -i your-key.pem bitnami@your-ip-address
```

**Explore the system**:
```bash
# See running services
sudo systemctl status apache2
sudo systemctl status mysql

# Check WordPress files
ls /opt/bitnami/wordpress/

# View logs
tail /opt/bitnami/apache/logs/access_log
```

## 🔧 Common Issues (Quick Fixes)

### Website not loading?
```bash
# Check if EC2 is running
aws ec2 describe-instances --instance-ids YOUR_INSTANCE_ID

# Check security group allows port 80
aws ec2 describe-security-groups --group-ids YOUR_SG_ID
```

### Can't SSH?
```bash
# Check key permissions
chmod 400 your-key.pem

# Use correct username
ssh -i your-key.pem bitnami@your-ip  # Not 'ec2-user'
```

### WordPress admin not working?
```bash
# Get admin password
sudo cat /home/bitnami/bitnami_credentials
```

## 🎓 What You Learned

After this tutorial, you understand:

- ✅ **Cloud Computing**: Rent vs buy servers
- ✅ **Amazon EC2**: Virtual servers in AWS
- ✅ **Security Groups**: Cloud firewalls
- ✅ **SSH Keys**: Secure authentication
- ✅ **LAMP Stack**: Web server components
- ✅ **WordPress**: Content management system
- ✅ **Cost Management**: AWS pricing model

## 🚀 Next Steps

### Beginner Level
1. Add more content to your blog
2. Try different WordPress themes
3. Install useful plugins
4. Set up Google Analytics

### Intermediate Level
1. Configure custom domain
2. Set up SSL certificate
3. Implement backup strategy
4. Monitor performance

### Advanced Level
1. Set up load balancer
2. Configure auto-scaling
3. Move database to RDS
4. Implement CI/CD pipeline

## 💡 Pro Tips

- **Always use Free Tier** for learning
- **Set billing alerts** to avoid surprises
- **Stop instances** when not needed
- **Take snapshots** before major changes
- **Use CloudWatch** for monitoring

---

**🎉 Congratulations!** You now understand Amazon EC2 and can deploy WordPress in the cloud. This knowledge applies to any web application, not just WordPress.

**Next**: Try deploying other applications or explore more AWS services!
