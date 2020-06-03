docker build -t hackenb/multi-client:latest -t hackenb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hackenb/multi-server:latest -t hackenb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hackenb/multi-worker:latest -t hackenb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hackenb/multi-client:latest
docker push hackenb/multi-server:latest
docker push hackenb/multi-worker:latest

docker push hackenb/multi-client:$SHA
docker push hackenb/multi-server:$SHA
docker push hackenb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hackenb/multi-server:$SHA
kubectl set image deployments/client-deployment client=hackenb/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=hackenb/multi-worker:$SHA