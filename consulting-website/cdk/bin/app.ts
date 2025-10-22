#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { ConsultingWebsiteStack } from '../lib/consulting-website-stack';

const app = new cdk.App();

new ConsultingWebsiteStack(app, 'CloudGenConsultingWebsite', {
  env: {
    // Specify your AWS account and region
    // account: process.env.CDK_DEFAULT_ACCOUNT,
    // region: process.env.CDK_DEFAULT_REGION,
    region: 'eu-west-1', // Netherlands-friendly region (Ireland)
  },
  description: 'Static website hosting for CloudGen Consulting using S3 and CloudFront',
});

app.synth();
