# Amazon EC2 WordPress Costs - Simple Breakdown

## 💰 Infrastructure Costs

- **Year 1**: FREE (AWS Free Tier)
- **Year 2+**: $9.55/month
- **Enterprise-grade hosting at competitive rates**

## 📊 Detailed Costs

### Free Tier (First 12 Months)
```yaml
What's Free:
├─ EC2 t3.micro: 750 hours/month (24/7 coverage)
├─ Storage: 30GB (we use 20GB)
├─ Data transfer: 15GB/month
└─ Total: $0.00/month
```

### After Free Tier
```yaml
Monthly Costs:
├─ EC2 t3.micro: $7.59
├─ Storage 20GB: $1.60
├─ Data transfer: $0.36 (5GB usage)
└─ Total: $9.55/month
```

## 🔍 Cost Comparison

| Service | Monthly Cost | What You Get |
|---------|-------------|--------------|
| **AWS EC2** | $9.55 | Full server control |
| GoDaddy | $12.99 | Shared hosting |
| Bluehost | $10.95 | Limited resources |
| DigitalOcean | $12.00 | Similar to EC2 |

**Winner**: AWS EC2 (most cost-effective with full control)

## 📈 Traffic-Based Costs

### Small Blog (1,000 visitors/month)
```yaml
Usage:
├─ Data transfer: 2GB
├─ CPU: <10%
└─ Cost: $9.28/month
```

### Medium Blog (10,000 visitors/month)
```yaml
Usage:
├─ Data transfer: 15GB
├─ CPU: 30%
├─ Upgrade to: t3.small
└─ Cost: $18.84/month
```

### Large Blog (100,000 visitors/month)
```yaml
Usage:
├─ Data transfer: 100GB
├─ CPU: 70%
├─ Upgrade to: t3.medium + Load Balancer
└─ Cost: $63.48/month
```

## 💡 Save Money Tips

### 1. Use Free Tier Fully
- Run 24/7 for 12 months = FREE
- Don't waste it on multiple small instances
- Perfect for learning and small projects

### 2. Stop When Not Needed
```bash
# Stop instance (keeps data, stops billing)
aws ec2 stop-instances --instance-ids YOUR_INSTANCE_ID

# Start when needed
aws ec2 start-instances --instance-ids YOUR_INSTANCE_ID
```
**Savings**: ~$5/month if stopped 16 hours daily

### 3. Reserved Instances (Long-term)
```yaml
1-Year Reserved:
├─ Upfront: $54 (save 40%)
├─ Monthly: $4.56 (vs $7.59)
└─ Best for: Permanent websites
```

### 4. Spot Instances (Advanced)
```yaml
Spot Pricing:
├─ Cost: ~$2.19/month (70% savings)
├─ Risk: Can be terminated
└─ Use for: Development/testing
```

## 🚨 Cost Alerts Setup

### Set Billing Alerts:
1. Go to AWS Billing Dashboard
2. Create budget: $10/month
3. Alert at 80% ($8)
4. Get email when approaching limit

### Monitor Daily:
```bash
# Check current month spending
aws ce get-cost-and-usage --time-period Start=2025-11-01,End=2025-11-30
```

## 📊 3-Year Total Cost

```yaml
Scenario 1 (On-Demand):
├─ Year 1: $0 (Free Tier)
├─ Year 2: $114.60
├─ Year 3: $114.60
└─ Total: $229.20

Scenario 2 (Reserved):
├─ Year 1: $0 (Free Tier)
├─ Year 2: $54.72 (Reserved)
├─ Year 3: $54.72 (Reserved)
└─ Total: $109.44 (52% savings)
```

## 🎯 Cost by Use Case

### Personal Blog
- **Traffic**: <1K visitors/month
- **Cost**: $9.55/month
- **Alternative**: $0 (use free platforms)
- **Why EC2**: Learn AWS, full control

### Business Website
- **Traffic**: 5-10K visitors/month
- **Cost**: $15-20/month
- **Alternative**: $25-50/month (managed hosting)
- **Why EC2**: 50% cheaper, more reliable

### E-commerce Site
- **Traffic**: 50K+ visitors/month
- **Cost**: $50-100/month
- **Alternative**: $200-500/month (enterprise hosting)
- **Why EC2**: 75% cheaper, enterprise features

## 🔧 Hidden Costs to Avoid

### Common Mistakes:
```yaml
Elastic IP (unused): $3.65/month
├─ Solution: Use dynamic IP or associate with instance

Multiple instances: $7.59 each
├─ Solution: Use one instance for learning

Large storage: $0.08/GB/month
├─ Solution: Start with 20GB, expand when needed

Data transfer: $0.09/GB
├─ Solution: Optimize images, use CDN
```

## 💰 Real User Costs

### Sarah (Student Blog):
- **Usage**: Personal blog, 500 visitors/month
- **Cost**: $0 (Free Tier)
- **Savings vs GoDaddy**: $156/year

### Mike (Business Site):
- **Usage**: Company website, 5K visitors/month
- **Cost**: $9.55/month
- **Savings vs Bluehost**: $15/month ($180/year)

### Lisa (E-commerce):
- **Usage**: Online store, 25K visitors/month
- **Cost**: $35/month (t3.small + extras)
- **Savings vs Shopify**: $44/month ($528/year)

---

**🎯 Bottom Line**: AWS EC2 is the cheapest way to host WordPress with full control. Start free, scale as you grow, save money long-term.
