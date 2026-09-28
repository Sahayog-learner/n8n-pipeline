For harbor registry follow following code
name: Build and Push Image

on:
  workflow_dispatch:
    inputs:
      branch:
        description: "Application branch to build"
        required: true
        type: string

      image_tag:
        description: "Docker image tag"
        required: true
        type: string

      image_name:
        description: "Docker image name"
        required: true
        type: string

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout application code
        uses: actions/checkout@v4
        with:
          ref: ${{ inputs.branch }}

      - name: Login to Harbor
        uses: docker/login-action@v3
        with:
          registry: ${{ secrets.HARBOR_REGISTRY }}
          username: ${{ secrets.HARBOR_USERNAME }}
          password: ${{ secrets.HARBOR_PASSWORD }}

      - name: Build Docker image
        run: |
          IMAGE="${{ secrets.HARBOR_REGISTRY }}/${{ secrets.HARBOR_PROJECT }}/${{ inputs.image_name }}:${{ inputs.image_tag }}"
          echo "Building ${IMAGE}"
          docker build -t "${IMAGE}" .

      - name: Push Docker image
        run: |
          IMAGE="${{ secrets.HARBOR_REGISTRY }}/${{ secrets.HARBOR_PROJECT }}/${{ inputs.image_name }}:${{ inputs.image_tag }}"
          docker push "${IMAGE}"