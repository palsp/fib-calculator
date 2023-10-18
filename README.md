# Fib Calculator

The Fibonacci Calculator is a web application that allows users to calculate Fibonacci sequences. The project is structured with client, server, and worker components, and it's designed to be containerized using Docker and orchestrated using Kubernetes.

This project serves as a hands-on practice for Docker and Kubernetes. While the application provides Fibonacci sequence calculations, the main focus is on the containerization of each component and the orchestration using Kubernetes.


## TODO
- [ ] refactor server, worker, and client deployment with [kustomize](https://github.com/kubernetes-sigs/kustomize)
- [ ] use [helm](https://helm.sh/docs/) for postgres and redis
- [ ] write github actions for the deployment