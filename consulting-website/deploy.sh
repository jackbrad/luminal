#!/bin/bash

# CloudGen Consulting Website Deployment Script
# This script simplifies the deployment process

set -e

echo "🚀 CloudGen Consulting Website Deployment"
echo "=========================================="
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first:"
    echo "   https://aws.amazon.com/cli/"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install it first:"
    echo "   https://nodejs.org/"
    exit 1
fi

# Check AWS credentials
echo "Checking AWS credentials..."
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Please run: aws configure"
    exit 1
fi

AWS_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
echo "✅ Connected to AWS Account: $AWS_ACCOUNT"
echo ""

# Navigate to CDK directory
cd "$(dirname "$0")/cdk"

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
    echo ""
fi

# Ask if this is first deployment
echo "Is this your first deployment in this AWS account/region? (y/n)"
read -r FIRST_DEPLOY

if [ "$FIRST_DEPLOY" = "y" ] || [ "$FIRST_DEPLOY" = "Y" ]; then
    echo ""
    echo "🔧 Bootstrapping CDK..."
    npx cdk bootstrap
    echo ""
fi

# Show what will be deployed
echo "📋 Previewing changes..."
npm run diff || true
echo ""

# Confirm deployment
echo "Ready to deploy to AWS. Continue? (y/n)"
read -r CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "Deployment cancelled."
    exit 0
fi

echo ""
echo "🚀 Deploying to AWS..."
npm run deploy

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Your website is now live. Check the output above for the CloudFront URL."
echo ""
