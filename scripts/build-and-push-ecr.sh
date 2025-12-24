#!/bin/bash
set -e

# -----------------------------
# INPUTS
# -----------------------------
BASE_VERSION=$1        # e.g. 1.0.0
TAGGER=$2              # e.g. vijay

if [[ -z "$BASE_VERSION" || -z "$TAGGER" ]]; then
  echo "Usage: $0 <base_version> <tagger_name>"
  echo "Example: $0 1.0.0 vijay"
  exit 1
fi

# -----------------------------
# CONSTANTS
# -----------------------------
AWS_REGION="eu-central-1"
AWS_ACCOUNT_ID="975050024946"
ECR_BASE="capstone-g3-gratitude"

ROOT_DIR="$(pwd)"
SERVICES_DIR="$ROOT_DIR/services"

# service-folder -> ecr-repo mapping
declare -A SERVICES=(
  ["api-gateway"]="api-gateway"
  ["entries-service"]="entries"
  ["moods-api"]="moods-api"
  ["moods-service"]="moods-service"
  ["stats-api"]="stats-api"
  ["stats-service"]="stats-service"
)

IMAGE_TAG="${BASE_VERSION}-${TAGGER}"

# -----------------------------
# ECR LOGIN
# -----------------------------
echo "Logging into ECR..."
aws ecr get-login-password \
  --region "$AWS_REGION" \
| docker login \
  --username AWS \
  --password-stdin \
  "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "ECR login successful"
echo "------------------------------------"

# -----------------------------
# BUILD & PUSH
# -----------------------------
for SERVICE_DIR in "${!SERVICES[@]}"; do
  ECR_REPO="${SERVICES[$SERVICE_DIR]}"
  IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_BASE}/${ECR_REPO}:${IMAGE_TAG}"

  echo "Building: $SERVICE_DIR -> $IMAGE_URI"

  docker build \
    -t "$IMAGE_URI" \
    -f "$SERVICES_DIR/$SERVICE_DIR/Dockerfile" \
    "$ROOT_DIR"

  echo "Pushing: $IMAGE_URI"
  docker push "$IMAGE_URI"

  echo "Done: $SERVICE_DIR"
  echo "------------------------------------"
done

echo "✅ All images built and pushed successfully"

