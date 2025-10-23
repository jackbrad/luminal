# DEPLOY YOUR WEBSITE NOW

Your CloudGen Consulting website is **ready to deploy**! Everything is built and configured.

## ⚠️ Environment Issue

The current environment has AWS API calls blocked, so I cannot deploy from here. But you can deploy from **any computer with internet access** in about 5 minutes.

## 🚀 Quick Deploy (From a Computer)

### Prerequisites
- **Node.js** installed (v18+): https://nodejs.org/
- **AWS CLI** installed: https://aws.amazon.com/cli/
- **Git** installed

### Option 1: Deploy with Your Existing IAM Credentials

```bash
# 1. Clone/pull the repository
git clone <your-repo-url>
cd luminal/consulting-website

# 2. Configure AWS credentials (use your own credentials)
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION=us-east-1

# 3. Navigate to CDK directory
cd cdk

# 4. Install dependencies
npm install

# 5. Bootstrap CDK (first time only)
npx cdk bootstrap

# 6. Deploy!
npx cdk deploy

# Done! You'll get a URL like: https://d1234567890abc.cloudfront.net
```

### Option 2: Deploy with AWS SSO (More Secure)

```bash
# 1. Clone/pull the repository
git clone <your-repo-url>
cd luminal/consulting-website

# 2. Login with SSO
aws sso login --sso-start-url https://d-9066363428.awsapps.com/start --sso-region us-east-1

# 3. Navigate to CDK directory
cd cdk

# 4. Install dependencies
npm install

# 5. Bootstrap CDK (first time only)
npx cdk bootstrap

# 6. Deploy!
npx cdk deploy

# Done! You'll get a URL like: https://d1234567890abc.cloudfront.net
```

## 📦 What Gets Deployed

- **S3 Bucket**: Hosts your website files (private, secure)
- **CloudFront Distribution**: Global CDN with HTTPS
- **Cost**: $1-5/month for typical traffic

## 🔒 Security Cleanup

**IMPORTANT**: After deployment, delete the temporary IAM user for security:

1. Go to AWS Console: https://console.aws.amazon.com/iam/
2. Users → `temp-cdk-deploy`
3. Delete user

Or use the command:
```bash
aws iam delete-access-key --access-key-id YOUR_ACCESS_KEY_ID --user-name temp-cdk-deploy
aws iam delete-user --user-name temp-cdk-deploy
```

## ⚡ Even Quicker - One Command

Run this single command from the repository root:

```bash
cd consulting-website && chmod +x deploy.sh && ./deploy.sh
```

## 🎯 Expected Output

After 15-20 minutes, you'll see:

```
✅ CloudGenConsultingWebsite

Outputs:
CloudGenConsultingWebsite.WebsiteURL = https://d1234567890abc.cloudfront.net
CloudGenConsultingWebsite.DistributionId = E1234567890ABC
CloudGenConsultingWebsite.BucketName = cloudgen-consulting-website-123456789012
```

**Visit that CloudFront URL - your website is LIVE!**

## 🔄 Updating the Website

To update content:

1. Edit files in `website/` directory
2. Run: `cd cdk && npx cdk deploy`
3. Wait ~5 minutes for CloudFront cache invalidation
4. Changes are live!

## ❓ Troubleshooting

### "Command not found: npx"
- Install Node.js: https://nodejs.org/

### "Command not found: aws"
- Install AWS CLI: https://aws.amazon.com/cli/

### "Unable to resolve credential"
- Run `aws configure` or export the credentials above

### "Bootstrap required"
- Run: `npx cdk bootstrap`

### Deployment takes too long
- First deployment: 15-20 minutes (CloudFront is slow to create)
- Subsequent deployments: 5-10 minutes

## 📞 Need Help?

Check the main README.md for detailed documentation, or reach out to your AWS administrator.

---

**Your website is ready to go - just needs to be deployed from a computer with AWS access! 🎉**
