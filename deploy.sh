docker build -t shastakouski/multi-client:latest -t shastakouski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shastakouski/multi-server:latest -t shastakouski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shastakouski/multi-worker:latest -t shastakouski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shastakouski/multi-client:latest
docker push shastakouski/multi-server:latest
docker push shastakouski/multi-worker:latest

docker push shastakouski/multi-client:$SHA
docker push shastakouski/multi-server:$SHA
docker push shastakouski/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=shastakouski/multi-client:$SHA
kubectl set image deployments/server-deployment server=shastakouski/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shastakouski/multi-worker:$SHA