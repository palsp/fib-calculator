SHA=$(git rev-parse HEAD)  

docker build --platform=linux/amd64 -t palsp/multi-server:latest -t palsp/multi-server:$SHA -f ./server/Dockerfile ./server

echo
echo "Pushing images of tag latest"
docker push palsp/multi-server:latest

echo 
echo "Pushing images of tag $SHA"
docker push palsp/multi-server:$SHA

cd k8s/server && kustomize edit set image palsp/multi-server=*:$SHA
cat kustomization.yaml && kustomize build . | kubectl apply -f -