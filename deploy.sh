SHA=$(git rev-parse HEAD)  
echo "SHA=$SHA"
echo "Build docker images"
docker build --platform=linux/amd64 -t palsp/multi-client:latest -t palsp/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build --platform=linux/amd64 -t palsp/multi-server:latest -t palsp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build --platform=linux/amd64 -t palsp/multi-worker:latest -t palsp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

echo
echo "Pushing images of tag latest"
docker push palsp/multi-client:latest
docker push palsp/multi-server:latest
docker push palsp/multi-worker:latest

echo
echo "Pushing images of tag $SHA"
docker push palsp/multi-client:$SHA
docker push palsp/multi-server:$SHA
docker push palsp/multi-worker:$SHA

echo
echo "Apply k8s config"
kubectl apply -f k8s
echo "Set image deployments"
kubectl set image deployments/server-deployment server=palsp/multi-server:$SHA
kubectl set image deployments/client-deployment client=palsp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=palsp/multi-worker:$SHA

