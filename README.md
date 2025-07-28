# new-horizon-ecs
new-horizon-ecs: creating a multi container AWS ECS cluster using terraform

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
  --query "InternetGateways[?Attachments[?VpcId=='vpc-0ec0b4e455023b995']]" \
  --region eu-west-1
```