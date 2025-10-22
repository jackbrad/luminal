# CloudGen Consulting Website

A modern, responsive website for a Netherlands-based Cloud and GenAI consulting firm. Built with HTML, CSS, and JavaScript, and deployed to AWS using S3 and CloudFront for cost-effective, global content delivery.

## Features

- **Modern Design**: Clean, professional design with smooth animations and responsive layout
- **Multi-Cloud Expertise**: Highlights capabilities across AWS, Azure, and Google Cloud Platform
- **SMB Focus**: Content tailored for small and medium-sized businesses
- **AI Training**: Showcases AI training programs for common platforms and custom agentic solutions
- **Cost-Effective Hosting**: Deployed via S3 + CloudFront for minimal AWS costs
- **Infrastructure as Code**: Complete AWS CDK deployment for easy updates

## Architecture

- **S3**: Static website hosting with private bucket access
- **CloudFront**: Global CDN for fast content delivery with HTTPS
- **Origin Access Control (OAC)**: Secure access to S3 content
- **Price Class 100**: Optimized for US, Canada, and Europe (lowest cost)

## Cost Estimate

Running this website on AWS is extremely cost-effective:

- **S3 Storage**: ~$0.023 per GB/month (website is < 1 MB)
- **CloudFront**:
  - First 10 TB: $0.085/GB (Europe/US)
  - Free tier: 1 TB data transfer out per month for first 12 months
- **Estimated monthly cost**: $1-5/month for typical SMB traffic

## Project Structure

```
consulting-website/
├── website/                 # Static website files
│   ├── index.html          # Main HTML file
│   ├── styles.css          # CSS styles
│   └── script.js           # JavaScript functionality
├── cdk/                    # AWS CDK infrastructure
│   ├── bin/
│   │   └── app.ts         # CDK app entry point
│   ├── lib/
│   │   └── consulting-website-stack.ts  # CDK stack definition
│   ├── package.json       # Node.js dependencies
│   ├── tsconfig.json      # TypeScript configuration
│   └── cdk.json          # CDK configuration
└── README.md             # This file
```

## Prerequisites

Before deploying, ensure you have:

1. **AWS Account**: An active AWS account
2. **AWS CLI**: Installed and configured with credentials
   ```bash
   aws configure
   ```
3. **Node.js**: Version 18.x or later
4. **npm**: Comes with Node.js

## Quick Start

### 1. Install Dependencies

Navigate to the CDK directory and install dependencies:

```bash
cd consulting-website/cdk
npm install
```

### 2. Bootstrap CDK (First Time Only)

If this is your first time using CDK in this AWS account/region:

```bash
npm run cdk bootstrap
```

### 3. Deploy to AWS

Deploy the website to AWS:

```bash
npm run deploy
```

The deployment will:
- Create an S3 bucket for website hosting
- Create a CloudFront distribution
- Upload website files to S3
- Configure Origin Access Control for security
- Output the CloudFront URL

### 4. Access Your Website

After deployment completes, you'll see output similar to:

```
Outputs:
CloudGenConsultingWebsite.WebsiteURL = https://d1234567890abc.cloudfront.net
CloudGenConsultingWebsite.DistributionId = E1234567890ABC
CloudGenConsultingWebsite.BucketName = cloudgen-consulting-website-123456789012
```

Visit the WebsiteURL to see your live website!

## Updating the Website

### Update Website Content

1. Modify files in the `website/` directory
2. Deploy changes:
   ```bash
   cd cdk
   npm run deploy
   ```

The deployment will automatically:
- Upload new files to S3
- Invalidate CloudFront cache
- Make changes live in ~5 minutes

### Update Infrastructure

1. Modify the CDK stack in `cdk/lib/consulting-website-stack.ts`
2. Preview changes:
   ```bash
   npm run diff
   ```
3. Deploy changes:
   ```bash
   npm run deploy
   ```

## Custom Domain (Optional)

To use a custom domain like `www.cloudgen.nl`:

1. Register domain in Route 53 or your DNS provider
2. Request SSL certificate in AWS Certificate Manager (us-east-1 region)
3. Update CDK stack to add:
   ```typescript
   certificate: certificate,
   domainNames: ['www.cloudgen.nl'],
   ```
4. Update DNS records to point to CloudFront distribution

## CDK Commands

- `npm run build` - Compile TypeScript to JavaScript
- `npm run watch` - Watch for changes and compile
- `npm run cdk synth` - Synthesize CloudFormation template
- `npm run diff` - Compare deployed stack with current state
- `npm run deploy` - Deploy stack to AWS
- `npm run destroy` - Remove all resources from AWS

## Cost Optimization Tips

1. **CloudFront Caching**: Default cache policy is optimized (24 hours)
2. **Price Class 100**: Uses cheapest CloudFront edge locations
3. **S3 Lifecycle**: Configure if you enable versioning
4. **Monitoring**: Set up billing alerts in AWS
5. **Reserved Capacity**: Not needed for static sites

## Security Features

- **Private S3 Bucket**: No public access
- **Origin Access Control**: CloudFront-only access to S3
- **HTTPS Only**: All traffic redirected to HTTPS
- **S3 Encryption**: Server-side encryption enabled
- **No Secrets**: No API keys or credentials in code

## Customization Guide

### Branding

1. **Company Name**: Update in `website/index.html`
2. **Colors**: Modify CSS variables in `website/styles.css`:
   ```css
   :root {
     --primary-color: #0066cc;
     --secondary-color: #00d4ff;
     /* ... */
   }
   ```
3. **Logo**: Add logo image and update HTML
4. **Contact Info**: Update email and details in contact section

### Content

- **Services**: Edit service cards in HTML
- **Cloud Platforms**: Modify cloud expertise section
- **Training Programs**: Update training offerings
- **Case Studies**: Add your own success stories

### Form Integration

The contact form currently shows an alert. For production:

1. **AWS SES**: Send emails via Amazon SES
2. **Lambda Function**: Process form with AWS Lambda
3. **API Gateway**: Create REST API endpoint
4. **DynamoDB**: Store submissions in database

Example Lambda integration:
```javascript
// In script.js, replace alert with:
fetch('https://your-api-gateway-url.amazonaws.com/contact', {
  method: 'POST',
  body: JSON.stringify(formData)
})
```

## Troubleshooting

### CloudFront Deployment Takes Long
- Initial CloudFront distributions take 15-20 minutes to deploy
- Subsequent updates are faster

### Changes Not Visible
- CloudFront caches content for 24 hours by default
- Wait 5 minutes after deployment for cache invalidation
- Or manually invalidate: `aws cloudfront create-invalidation --distribution-id EXXXXX --paths "/*"`

### Deployment Fails
- Ensure AWS credentials are configured: `aws sts get-caller-identity`
- Check CDK is bootstrapped: `cdk bootstrap`
- Verify bucket name is unique (includes account ID)

### Cost Concerns
- Enable billing alerts in AWS Console
- Check AWS Cost Explorer monthly
- Most costs come from data transfer (first 1 TB free for 12 months)

## Support & Resources

- [AWS CDK Documentation](https://docs.aws.amazon.com/cdk/)
- [CloudFront Pricing](https://aws.amazon.com/cloudfront/pricing/)
- [S3 Pricing](https://aws.amazon.com/s3/pricing/)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

## License

This project is provided as-is for CloudGen Consulting. Modify as needed for your business.

## Next Steps

1. **Custom Domain**: Set up www.cloudgen.nl or your domain
2. **Analytics**: Add Google Analytics or AWS CloudWatch RUM
3. **SEO**: Add meta tags, sitemap.xml, robots.txt
4. **Blog**: Consider adding a blog section
5. **Contact Form Backend**: Integrate AWS SES + Lambda
6. **Multi-language**: Add Dutch language support
7. **Performance**: Run Lighthouse audits and optimize
8. **Monitoring**: Set up CloudWatch dashboards

## Maintenance

- **Monthly**: Check AWS billing and usage
- **Quarterly**: Review and update content
- **Yearly**: Update dependencies and CDK version
- **As Needed**: Deploy content updates

---

Built with ❤️ for CloudGen Consulting | Deployed on AWS
