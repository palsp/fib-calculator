# Fib Calculator

The Fibonacci Calculator is a web application that allows users to calculate Fibonacci sequences. The project is structured with client, server, and worker components, and it's designed to be containerized using Docker and orchestrated using Kubernetes.

This project serves as a hands-on practice for Docker and Kubernetes. While the application provides Fibonacci sequence calculations, the main focus is on the containerization of each component and the orchestration using Kubernetes.


## TODO
- [x] refactor server, worker, and client deployment with [kustomize](https://github.com/kubernetes-sigs/kustomize)
- [ ] generate secret and config from env [ref](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)
- [ ] use [helm](https://helm.sh/docs/) for postgres and redis
- [ ] write github actions for the deployment


## Prerequisite
- docker
- kubernetes (can use docker desktop)
- [helm](https://helm.sh/docs/)
- [kustomize](https://github.com/kubernetes-sigs/kustomize)

## Development

1. install [ingress-nginx](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start) using helm

2. create `postgres-secret.yaml` and replace  POSTGRES_PASSWORD with your password encoded in base64.
```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: postgres-secret
  data:
    POSTGRES_PASSWORD: <POSTGRES_PASSWORD>
```

then apply change to cluster
```sh
kubectl apply -f postgres-secret.yaml
```

3. create `server-secret.yaml` and replace  POSTGRES_PASSWORD with previous password encoded in base64.

```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: server-secret
  data:
    PGPASSWORD:  <POSTGRES_PASSWORD>
```

then apply change to cluster
```sh
kubectl apply -f server-secret.yaml
```

4. deploy postgres, redis and ingress
```sh
kubectl apply -f k8s
```

5. deploy server

```sh
kubectl apply -k k8s/server
```

6. deploy worker
```sh
kubectl apply -k k8s/worker
```

7. deploy client

```sh
kubectl apply -k k8s/client
```

8. visit http://localhost:80

