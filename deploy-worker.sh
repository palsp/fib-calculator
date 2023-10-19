SHA=$(git rev-parse HEAD)  

docker build --platform=linux/amd64 -t palsp/multi-worker:latest -t palsp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

echo
echo "Pushing images of tag latest"
docker push palsp/multi-worker:latest

echo 
echo "Pushing images of tag $SHA"
docker push palsp/multi-worker:$SHA

cd k8s/worker && kustomize edit set image palsp/multi-worker=*:$SHA
cat kustomization.yaml && kustomize build . | kubectl apply -f -