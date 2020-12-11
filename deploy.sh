docker build -t djohal/multi-client:latest -t djohal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t djohal/multi-server:latest -t djohal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t djohal/multi-worker:latest -t djohal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push djohal/multi-client:latest
docker push djohal/multi-server:latest
docker push djohal/multi-worker:latest

docker push djohal/multi-client:$SHA
docker push djohal/multi-server:$SHA
docker push djohal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=djohal/multi-server:$SHA
kubectl set image deployments/client-deployment client=djohal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=djohal/multi-worker:$SHA