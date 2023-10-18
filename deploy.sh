docker build -t palsp/multi-client:latest -t palsp/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t palsp/multi-server:latest -t palsp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t palsp/multi-worker:latest -t palsp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push palsp/multi-client:latest
docker push palsp/multi-server:latest
docker push palsp/multi-worker:latest

docker push palsp/multi-client:$SHA
docker push palsp/multi-server:$SHA
docker push palsp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=palsp/multi-server:$SHA
kubectl set image deployments/client-deployment client=palsp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=palsp/multi-worker:$SHA

