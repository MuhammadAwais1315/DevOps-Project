#!/bin/bash

# Set your DockerHub username
DOCKERHUB_USERNAME=22i1315

# Define the list of services and their paths
declare -A SERVICES=(
  #[frontend]=src/frontend
  #[cartservice]=src/cartservice/src
 # [checkoutservice]=src/checkoutservice
  #[currencyservice]=src/currencyservice
  [emailservice]=src/emailservice
  [paymentservice]=src/paymentservice
  [productcatalog]=src/productcatalogservice
 # [recommendation]=src/recommendationservice
  #[shippingservice]=src/shippingservice
  [adservice]=src/adservice
  #[loadgenerator]=src/loadgenerator
)

# Loop through each service, build and push
for SERVICE in "${!SERVICES[@]}"; do
  SERVICE_PATH="${SERVICES[$SERVICE]}"
  IMAGE_NAME="$DOCKERHUB_USERNAME/$SERVICE:latest"

  echo "🔨 Building $SERVICE..."
  docker build -t "$IMAGE_NAME" "$SERVICE_PATH" || { echo "❌ Failed to build $SERVICE"; exit 1; }

  echo "📤 Pushing $SERVICE..."
  docker push "$IMAGE_NAME" || { echo "❌ Failed to push $SERVICE"; exit 1; }

  echo "✅ Done with $SERVICE"
done

# Note: Redis uses official image
echo "📦 Skipping Redis (use official redis image: redis:alpine)"
