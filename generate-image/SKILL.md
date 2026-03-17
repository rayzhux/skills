---
name: generate-image
description: Generate images using Nano Banana 2 (Gemini 3.1 Flash Image) for websites, illustrations, hero images, icons, and backgrounds
invocable: true
---

# Image Generation Skill — Nano Banana 2

Generate images using Google's Nano Banana 2 (gemini-3.1-flash-image-preview) model.

## When to use

Use this skill when the user asks you to:
- Generate photos, illustrations, or images for websites
- Create hero images, backgrounds, banners, or icons
- Design visual assets for web projects
- Generate any image from a text description

## How to generate an image

Run the generation script:

```bash
~/.claude/skills/generate-image/generate.sh "<prompt>" "<aspect_ratio>" "<image_size>" "<output_path>"
```

### Parameters

- **prompt** (required): A detailed description of the image to generate. Be specific about style, colors, composition, lighting, and mood. For website assets, include context like "for a modern SaaS landing page" or "minimalist flat illustration style".
- **aspect_ratio** (optional, default: "16:9"): Options:
  - `16:9` — hero images, banners
  - `1:1` — profile pics, icons, thumbnails
  - `4:3` — blog post images
  - `9:16` — mobile/story format
  - `3:4` — portrait images
- **image_size** (optional, default: "2K"): Resolution options:
  - `1K` — smaller, faster
  - `2K` — high quality (recommended)
- **output_path** (optional, default: "generated_image.png"): Where to save the image. Use descriptive names like `hero-bg.png`, `about-illustration.png`.

### Tips for great website images

- Be specific: "A serene mountain landscape at golden hour with soft clouds, photorealistic, cinematic lighting" beats "mountains"
- Specify style: "flat vector illustration", "3D rendered", "watercolor", "photorealistic", "minimalist line art"
- For consistency across a site, reuse style descriptors in every prompt
- Generate images at the right aspect ratio for their placement
- Save images in the project's assets/images directory

### After generating

- Use the Read tool to view the generated image and verify it looks good
- If the image isn't right, regenerate with a refined prompt
- When building websites, reference the generated image path in your HTML/CSS
