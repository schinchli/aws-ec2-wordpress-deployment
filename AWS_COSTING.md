# AWS EC2 WordPress Costing Analysis

## 💰 Current Deployment Costs

### Instance Configuration
- **Instance Type**: t3.micro
- **Region**: us-east-1 (N. Virginia)
- **Operating System**: Linux
- **Tenancy**: Shared
- **Deployment**: Single instance

## 📊 Detailed Cost Breakdown

### 1. EC2 Instance Costs

#### t3.micro Pricing (us-east-1)
```yaml
On-Demand Pricing:
├─ Hourly Rate: $0.0104 per hour
├─ Daily Cost: $0.25 per day (24 hours)
├─ Monthly Cost: $7.59 per month (730 hours)
└─ Annual Cost: $91.10 per year

Free Tier Benefits:
├─ Eligible: Yes (first 12 months)
├─ Free Hours: 750 hours per month
├─ Coverage: Covers 24/7 operation
└─ Effective Cost: $0.00 per month (Year 1)
```

#### Instance Specifications
```yaml
t3.micro Specifications:
├─ vCPUs: 2
├─ Memory: 1 GiB
├─ Network Performance: Up to 5 Gigabit
├─ EBS Bandwidth: Up to 2,085 Mbps
├─ CPU Credits: Burstable performance
└─ Storage: EBS-only
```

### 2. EBS Storage Costs

#### Root Volume (gp3)
```yaml
EBS gp3 Volume:
├─ Size: 20 GB
├─ Type: General Purpose SSD (gp3)
├─ IOPS: 3,000 (baseline)
├─ Throughput: 125 MiB/s (baseline)

Monthly Costs:
├─ Storage: 20 GB × $0.08/GB = $1.60/month
├─ IOPS: 3,000 (included, no extra cost)
├─ Throughput: 125 MiB/s (included, no extra cost)
└─ Total EBS: $1.60/month

Free Tier Benefits:
├─ Free Storage: 30 GB per month
├─ Coverage: Covers our 20 GB volume
└─ Effective Cost: $0.00/month (Year 1)
```

### 3. Data Transfer Costs

#### Internet Data Transfer
```yaml
Data Transfer OUT (to Internet):
├─ First 1 GB/month: Free
├─ Next 9.999 TB/month: $0.09/GB
├─ Next 40 TB/month: $0.085/GB
├─ Next 100 TB/month: $0.07/GB
└─ Over 150 TB/month: $0.05/GB

Estimated Usage (Small Blog):
├─ Monthly Transfer: ~5 GB
├─ Free Tier: 1 GB
├─ Billable: 4 GB × $0.09 = $0.36/month
└─ Total Transfer: $0.36/month

Free Tier Benefits:
├─ Free Transfer: 15 GB per month
├─ Coverage: Covers typical blog usage
└─ Effective Cost: $0.00/month (Year 1)
```

### 4. Additional AWS Services

#### Elastic IP (Optional)
```yaml
Elastic IP Costs:
├─ Associated with running instance: Free
├─ Additional IPs: $0.005/hour ($3.65/month)
├─ Unassociated IP: $0.005/hour
└─ Current Setup: Using dynamic IP (Free)
```

#### Route 53 (Optional Domain)
```yaml
Route 53 Costs (if using custom domain):
├─ Hosted Zone: $0.50/month
├─ DNS Queries: $0.40 per million queries
├─ Health Checks: $0.50/month per check
└─ Current Setup: Using IP address (Free)
```

## 📈 Cost Scenarios

### Scenario 1: Free Tier (First 12 Months)
```yaml
Monthly Costs:
├─ EC2 t3.micro: $0.00 (750 hours free)
├─ EBS 20GB gp3: $0.00 (30GB free)
├─ Data Transfer: $0.00 (15GB free)
├─ Elastic IP: $0.00 (using dynamic IP)
└─ Total Monthly: $0.00

Annual Cost (Year 1): $0.00
```

### Scenario 2: After Free Tier (Year 2+)
```yaml
Monthly Costs:
├─ EC2 t3.micro: $7.59
├─ EBS 20GB gp3: $1.60
├─ Data Transfer: $0.36 (estimated 5GB)
├─ Elastic IP: $0.00 (using dynamic IP)
└─ Total Monthly: $9.55

Annual Cost: $114.60
```

### Scenario 3: Production Setup
```yaml
Enhanced Configuration:
├─ Instance: t3.small ($15.18/month)
├─ EBS: 50GB gp3 ($4.00/month)
├─ Elastic IP: $3.65/month
├─ Route 53: $0.50/month
├─ Data Transfer: $2.00/month (estimated)
└─ Total Monthly: $25.33

Annual Cost: $304.00
```

## 🔍 Cost Optimization Strategies

### 1. Instance Right-Sizing
```yaml
Performance Monitoring:
├─ Monitor CPU utilization
├─ Track memory usage
├─ Analyze network patterns
└─ Adjust instance type accordingly

Optimization Options:
├─ Downsize: t3.nano ($3.80/month) for low traffic
├─ Current: t3.micro ($7.59/month) for moderate traffic
├─ Upsize: t3.small ($15.18/month) for high traffic
└─ Burstable: Use T3 unlimited for consistent performance
```

### 2. Storage Optimization
```yaml
EBS Optimization:
├─ Monitor storage usage
├─ Use gp3 instead of gp2 (better price/performance)
├─ Right-size volume capacity
└─ Enable EBS optimization

Cost Comparison:
├─ gp2 20GB: $2.00/month
├─ gp3 20GB: $1.60/month (20% savings)
├─ gp3 benefits: Better IOPS and throughput baseline
└─ Recommendation: Use gp3 for new deployments
```

### 3. Reserved Instances
```yaml
Reserved Instance Savings:
├─ 1-Year Term: Up to 40% savings
├─ 3-Year Term: Up to 60% savings
├─ Payment Options: All upfront, partial, no upfront
└─ Convertible: Can change instance family

t3.micro Reserved Pricing (1-Year):
├─ No Upfront: $4.56/month (40% savings)
├─ Partial Upfront: $4.38/month (42% savings)
├─ All Upfront: $4.20/month (45% savings)
└─ Best for: Predictable, long-term workloads
```

### 4. Spot Instances (Development)
```yaml
Spot Instance Pricing:
├─ Discount: Up to 90% off On-Demand
├─ t3.micro Spot: ~$0.003/hour ($2.19/month)
├─ Interruption: Can be terminated with 2-minute notice
└─ Use Case: Development, testing, fault-tolerant workloads
```

## 📊 Traffic-Based Cost Projections

### Low Traffic Blog (1,000 visitors/month)
```yaml
Resource Usage:
├─ Data Transfer: ~2 GB/month
├─ CPU Usage: <10% average
├─ Memory Usage: <50%
└─ Storage Growth: ~1 GB/month

Monthly Costs (After Free Tier):
├─ EC2: $7.59
├─ EBS: $1.60
├─ Transfer: $0.09 (1GB billable)
└─ Total: $9.28/month
```

### Medium Traffic Blog (10,000 visitors/month)
```yaml
Resource Usage:
├─ Data Transfer: ~15 GB/month
├─ CPU Usage: 20-30% average
├─ Memory Usage: 60-70%
└─ Storage Growth: ~2 GB/month

Recommended Upgrade: t3.small
Monthly Costs:
├─ EC2: $15.18
├─ EBS: $2.40 (30GB)
├─ Transfer: $1.26 (14GB billable)
└─ Total: $18.84/month
```

### High Traffic Blog (100,000 visitors/month)
```yaml
Resource Usage:
├─ Data Transfer: ~100 GB/month
├─ CPU Usage: 50-70% average
├─ Memory Usage: 80%+
└─ Storage Growth: ~5 GB/month

Recommended Setup:
├─ Instance: t3.medium ($30.37/month)
├─ EBS: 100GB gp3 ($8.00/month)
├─ Load Balancer: $16.20/month
├─ Transfer: $8.91/month (99GB billable)
└─ Total: $63.48/month
```

## 🎯 Cost Monitoring and Alerts

### AWS Cost Management Tools
```yaml
Available Tools:
├─ AWS Cost Explorer: Visualize spending patterns
├─ AWS Budgets: Set cost and usage alerts
├─ AWS Cost Anomaly Detection: Detect unusual spending
└─ AWS Billing Dashboard: Real-time cost tracking

Recommended Alerts:
├─ Monthly Budget: $10 (with 80% alert)
├─ Daily Spend: $0.50 threshold
├─ Service-specific: EC2, EBS separate tracking
└─ Forecasted: Alert if projected to exceed budget
```

### Cost Optimization Checklist
```yaml
Monthly Review:
├─ ✅ Check instance utilization (CloudWatch)
├─ ✅ Review data transfer patterns
├─ ✅ Analyze storage usage and growth
├─ ✅ Evaluate Reserved Instance opportunities
├─ ✅ Consider Spot Instances for dev/test
├─ ✅ Review and optimize security groups
└─ ✅ Clean up unused resources (snapshots, volumes)
```

## 💡 Cost-Effective Alternatives

### 1. AWS Lightsail
```yaml
Lightsail WordPress:
├─ Instance: $3.50/month (512MB RAM, 1 vCPU)
├─ Instance: $5.00/month (1GB RAM, 1 vCPU)
├─ Instance: $10.00/month (2GB RAM, 1 vCPU)
├─ Includes: SSD storage, data transfer, static IP
├─ Benefits: Simplified pricing, managed WordPress
└─ Trade-offs: Less flexibility, limited AWS integration
```

### 2. Managed WordPress Services
```yaml
Alternative Options:
├─ AWS Lightsail: $3.50-$10/month
├─ DigitalOcean: $4-$12/month
├─ Linode: $5-$10/month
├─ Vultr: $2.50-$6/month
└─ Traditional hosting: $3-$15/month

AWS Benefits:
├─ Full AWS ecosystem integration
├─ Advanced monitoring and logging
├─ Scalability options
├─ Enterprise security features
└─ Learning AWS cloud concepts
```

## 📋 Cost Summary

### Current Deployment (Free Tier)
- **Year 1 Cost**: $0.00/month
- **After Free Tier**: $9.55/month
- **Break-even**: 12 months of free usage
- **ROI**: Excellent for learning and small projects

### Recommendations
1. **Start with Free Tier**: Maximize 12 months of free usage
2. **Monitor Usage**: Set up billing alerts and cost tracking
3. **Right-size Resources**: Adjust based on actual usage patterns
4. **Consider Reserved Instances**: For predictable, long-term workloads
5. **Optimize Regularly**: Monthly cost reviews and optimization

### Total Cost of Ownership (3 Years)
```yaml
3-Year TCO Analysis:
├─ Year 1: $0.00 (Free Tier)
├─ Year 2: $114.60 (On-Demand)
├─ Year 3: $114.60 (On-Demand)
├─ Total: $229.20
├─ Alternative (Reserved): $179.40 (22% savings)
└─ Monthly Average: $6.37/month over 3 years
```
