SHA=$(git rev-parse HEAD)  

docker build --platform=linux/amd64 -t palsp/multi-client:latest -t palsp/multi-client:$SHA -f ./client/Dockerfile ./client

echo
echo "Pushing images of tag latest"
docker push palsp/multi-client:latest

echo 
echo "Pushing images of tag $SHA"
docker push palsp/multi-client:$SHA

cd k8s/client && kustomize edit set image palsp/multi-client=*:$SHA
cat kustomization.yaml && kustomize build . | kubectl apply -f -