docker build -t dunphyal/multi-client:latest -t dunphyal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dunphyal/multi-server:latest -t dunphyal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dunphyal/multi-worker:latest -t dunphyal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dunphyal/multi-client:latest   
docker push dunphyal/multi-server:latest
docker push dunphyal/multi-worker:latest

docker push dunphyal/multi-client:$SHA
docker push dunphyal/multi-server:$SHA
docker push dunphyal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dunphyal/multi-server:$SHA

kubectl set image deployments/client-deployment server=dunphyal/multi-client:$SHA

kubectl set image deployments/worker-deployment server=dunphyal/multi-worker:$SHA