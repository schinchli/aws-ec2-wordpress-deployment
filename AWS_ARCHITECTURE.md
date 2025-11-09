# Amazon EC2 WordPress Architecture - Simple Guide

## 🏗️ Simple Architecture

```
Internet → AWS Security → Amazon EC2 → WordPress Blog
             (Firewall)    (Server)     (Website)
```

## 🔧 What's Inside Amazon EC2

```
Amazon EC2 Instance (t3.micro)
├─ WordPress 6.8 (Your blog)
├─ Apache (Web server)
├─ MySQL (Database)
├─ PHP (Programming language)
└─ Linux (Operating system)
```

## 🌐 Network Setup

### Your WordPress URL
- **Public IP**: 54.196.248.208
- **Website**: http://54.196.248.208
- **Admin**: http://54.196.248.208/wp-admin

### Security (Firewall Rules)
```yaml
Allow:
├─ Port 80 (HTTP) - Website visitors
├─ Port 22 (SSH) - Admin access
Block:
└─ Everything else - Hackers
```

## 💾 Storage

```yaml
Hard Drive (20GB):
├─ Operating System: 3GB
├─ WordPress: 1GB
├─ Your content: 16GB available
└─ Type: SSD (fast)
```

## 🔄 How It Works

### When someone visits your blog:

1. **Browser** → Types your website URL
2. **Internet** → Routes to AWS
3. **Security Group** → Checks if allowed (Port 80)
4. **Apache** → Receives the request
5. **PHP** → Runs WordPress code
6. **MySQL** → Gets blog content
7. **Apache** → Sends webpage back
8. **Browser** → Shows your blog

## 📊 Server Specs

```yaml
Amazon EC2 t3.micro:
├─ CPU: 2 cores (burstable)
├─ RAM: 1GB
├─ Storage: 20GB SSD
├─ Network: Up to 5 Gbps
├─ Cost: $7.59/month (Free first year)
└─ Perfect for: Small to medium blogs
```

## 🔐 Security Layers

```
1. AWS Infrastructure Security (Amazon handles)
2. Security Groups (You configure)
3. SSH Keys (You manage)
4. WordPress Security (Keep updated)
```

## 📈 Scaling Options

### Traffic Growth Plan:
```yaml
Small Blog (1K visitors/month):
└─ t3.micro ($7.59/month) ✓ Current setup

Medium Blog (10K visitors/month):
└─ t3.small ($15.18/month) ← Upgrade when needed

Large Blog (100K visitors/month):
├─ t3.medium ($30.37/month)
├─ Load Balancer ($16.20/month)
└─ Multiple servers for high availability
```

## 🌍 Global Reach

```yaml
AWS Region: us-east-1 (N. Virginia)
├─ Low latency for US East Coast
├─ Can deploy in other regions
├─ 25+ regions worldwide
└─ Choose closest to your audience
```

## 🔧 Management

### Start/Stop Server:
```bash
# Stop (saves money)
aws ec2 stop-instances --instance-ids i-037b4d777295f2bf3

# Start (resume website)
aws ec2 start-instances --instance-ids i-037b4d777295f2bf3
```

### Connect to Server:
```bash
ssh -i your-key.pem bitnami@54.196.248.208
```

## 💰 Cost Breakdown

```yaml
Monthly Costs:
├─ EC2 t3.micro: $7.59
├─ Storage 20GB: $1.60
├─ Data transfer: $0.36
├─ Total: $9.55/month
└─ Free Tier: $0 first year
```

## 🚀 Why This Architecture?

### Pros:
- ✅ **Simple**: Easy to understand and manage
- ✅ **Cheap**: Under $10/month
- ✅ **Scalable**: Upgrade when you grow
- ✅ **Reliable**: 99.9% uptime
- ✅ **Secure**: Enterprise-grade security

### Cons:
- ❌ **Single point of failure**: One server
- ❌ **Manual scaling**: Need to upgrade manually
- ❌ **Basic backup**: Need to set up backups

### Perfect For:
- Personal blogs
- Small business websites
- Learning AWS
- Portfolio projects
- Development/testing

---

**🎯 This architecture gets you started with AWS. As you grow, you can add load balancers, databases, and CDNs for enterprise-scale applications.**
