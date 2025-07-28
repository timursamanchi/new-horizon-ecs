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

docker buildx build --platform=linux/amd64,linux/arm64 --no-cache --push -t 040929397520.dkr.ecr.eu-west-2.amazonaws.com/quote-frontend:v01 ./frontend
docker buildx build --platform=linux/amd64,linux/arm64 --no-cache --push -t 040929397520.dkr.ecr.eu-west-2.amazonaws.com/quote-backend:v01 ./backend
```


## commands - to be deleted before go-live
dockerhub/ECR login
```
# Authenticate Docker to ECR (update region accordingly)
aws ecr get-login-password \
  --region eu-west-1 | \
  docker login --username AWS \
  --password-stdin 040929397520.dkr.ecr.eu-west-1.amazonaws.com

```
delete all docker images, services and containers
```
docker ps -q | xargs -r docker stop
docker ps -aq | xargs -r docker rm

docker images -q | xargs -r docker rmi -f

docker rmi -f $(docker images -q)

# check all removed
docker images        # should show nothing or minimal
docker ps -a         # should show no containers
docker volume ls     # should be mostly empty



```


Check internet gateway
```
aws ec2 describe-internet-gateways \
  --query "InternetGateways[?Attachments[?VpcId=='vpc-<id>']]" \
  --region eu-west-1
```

create ECR repository
```
# Create an ECR repository
aws ecr create-repository --repository-name <name>
```

aws ecs list-tasks \
  --cluster quoteApp-ecsCluster \
  --service-name quoteApp-frontend-service \
  --query "taskArns[0]" \
  --output text

aws ecs describe-tasks \
  --cluster quoteApp-ecsCluster \
  --tasks arn:aws:ecs:eu-west-2:040929397520:task/quoteApp-ecsCluster/9f71f65f850c4a68bca13ba6bf4a1098 \
  --query "tasks[0].containers[*].name" \
  --output text


aws ecs execute-command \
  --cluster quoteApp-ecsCluster \
  --task arn:aws:ecs:eu-west-2:040929397520:task/quoteApp-ecsCluster/9f71f65f850c4a68bca13ba6bf4a1098 \
  --container quote-frontend \
  --command "/bin/sh" \
  --interactive
