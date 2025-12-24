#!/bin/bash
set -e

# -----------------------------
# INPUTS
# -----------------------------
BASE_VERSION=$1     # e.g. 1.0.0
TAGGER=$2           # e.g. vijay

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
IMAGE_TAG="${BASE_VERSION}-${TAGGER}"

# folder -> ecr repo mapping
declare -A COMPONENTS=(
  ["client"]="client"
  ["services/server-main"]="server"
)

# -----------------------------
# ECR LOGIN
# -----------------------------
echo "Logging into AWS ECR..."
aws ecr get-login-password --region "$AWS_REGION" \
| docker login --username AWS --password-stdin \
"${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "ECR login successful"
echo "-------------------------------------"

# -----------------------------
# BUILD & PUSH
# -----------------------------
for DIR in "${!COMPONENTS[@]}"; do
  REPO="${COMPONENTS[$DIR]}"
  IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_BASE}/${REPO}:${IMAGE_TAG}"

  echo "Building image for $DIR"
  docker build -t "$IMAGE_URI" "$ROOT_DIR/$DIR"

  echo "Pushing image: $IMAGE_URI"
  docker push "$IMAGE_URI"

  echo "Done: $DIR"
  echo "-------------------------------------"
done

echo "✅ Client & Server images built and pushed successfully"

