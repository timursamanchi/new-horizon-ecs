# ECS Quote App Deployment (Front/Backend)
new-horizon-ecs: creating a multi container AWS ECS cluster using terraform

## 🚀 Running Both Containers in a Single Fargate Task Definition

### ✅ Steps to Deploy

1. **Create and Prepare Your Docker Images**
   - `quote-backend`: simple quote server (e.g., `datawire/quote`)
   - `quote-frontend`: NGINX + index.html + JS fetch from `/quote`

2. **Create ECR Repositories**
   ```bash
   aws ecr create-repository --repository-name quote-backend
   aws ecr create-repository --repository-name quote-frontend
   ```

3. **Build tag and push docker images to dockerhub/ECR. 
```

docker buildx build --platform=linux/amd64,linux/arm64 --no-cache --push -t quote-frontend:v02 ./frontend
docker buildx build --platform=linux/amd64,linux/arm64 --no-cache --push -t quote-backend:v02 ./backend
```


