#!/bin/bash
# Nano Banana 2 (gemini-3.1-flash-image-preview) Image Generation Script
# Uses Google AI Studio / Gemini API

set -euo pipefail

PROMPT="${1:?Usage: generate.sh <prompt> [aspect_ratio] [image_size] [output_path]}"
ASPECT_RATIO="${2:-16:9}"
IMAGE_SIZE="${3:-2K}"
OUTPUT_PATH="${4:-generated_image.png}"
MODEL="gemini-3.1-flash-image-preview"

if [ -z "${GEMINI_API_KEY:-}" ]; then
  echo "Error: GEMINI_API_KEY environment variable is not set." >&2
  echo "Get your key at: https://aistudio.google.com/apikey" >&2
  exit 1
fi

# Build request payload
PAYLOAD=$(jq -n \
  --arg prompt "$PROMPT" \
  --arg aspect "$ASPECT_RATIO" \
  --arg size "$IMAGE_SIZE" \
  '{
    contents: [{
      parts: [{ text: $prompt }]
    }],
    generationConfig: {
      responseModalities: ["TEXT", "IMAGE"],
      imageConfig: {
        aspectRatio: $aspect,
        imageSize: $size
      }
    }
  }')

# Call the Gemini API
RESPONSE=$(curl -s -X POST \
  "https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent?key=${GEMINI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

# Check for errors
ERROR=$(echo "$RESPONSE" | jq -r '.error.message // empty')
if [ -n "$ERROR" ]; then
  echo "API Error: $ERROR" >&2
  exit 1
fi

# Extract base64 image data from response
IMAGE_DATA=$(echo "$RESPONSE" | jq -r '
  .candidates[0].content.parts[]
  | select(.inlineData)
  | .inlineData.data // empty
')

if [ -z "$IMAGE_DATA" ]; then
  TEXT_RESPONSE=$(echo "$RESPONSE" | jq -r '
    .candidates[0].content.parts[]
    | select(.text)
    | .text // empty
  ')
  echo "No image was generated." >&2
  if [ -n "$TEXT_RESPONSE" ]; then
    echo "Model response: $TEXT_RESPONSE" >&2
  fi
  exit 1
fi

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT_PATH")"

# Decode and save
echo "$IMAGE_DATA" | base64 -d > "$OUTPUT_PATH"

# Get file size for confirmation
FILE_SIZE=$(ls -lh "$OUTPUT_PATH" | awk '{print $5}')
echo "Image saved to: $OUTPUT_PATH ($FILE_SIZE)"
