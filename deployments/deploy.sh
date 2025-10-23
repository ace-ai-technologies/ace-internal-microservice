#!/bin/bash

set -e

echo "🚀 Starting deployment of ACE Internal Microservice..."

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI is not installed. Please install it first."
    exit 1
fi

# Set project ID (replace with your actual project ID)
PROJECT_ID="your-gcp-project-id"
REGION="us-central1"

echo "📋 Configuration:"
echo "   Project ID: $PROJECT_ID"
echo "   Region: $REGION"
echo "   Service: ace-internal-microservice"

# Build and push Docker image
echo "🏗️  Building Docker image..."
gcloud builds submit --tag gcr.io/$PROJECT_ID/ace-internal-microservice:latest

# Deploy to Cloud Run
echo "🚀 Deploying to Cloud Run..."
gcloud run deploy ace-internal-microservice \
    --image gcr.io/$PROJECT_ID/ace-internal-microservice:latest \
    --region $REGION \
    --platform managed \
    --allow-unauthenticated=false \
    --memory 512Mi \
    --cpu 1 \
    --max-instances 10 \
    --set-env-vars="NODE_ENV=production" \
    --set-env-vars="PORT=8080" \
    --set-env-vars="JWT_SECRET=${JWT_SECRET}" \
    --set-env-vars="ALLOWED_ORIGINS=${ALLOWED_ORIGINS}"

echo "✅ Deployment completed successfully!"
echo "🌐 Service URL: $(gcloud run describe ace-internal-microservice --region=$REGION --format='value(status.url)')"