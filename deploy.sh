docker build -t pauloneto94/multi-client:latest -t pauloneto94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pauloneto94/multi-server:latest -t pauloneto94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pauloneto94/multi-worker:latest -t pauloneto94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pauloneto94/multi-client:latest
docker push pauloneto94/multi-server:latest
docker push pauloneto94/multi-worker:latest

docker push pauloneto94/multi-client:$SHA
docker push pauloneto94/multi-server:$SHA
docker push pauloneto94/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=pauloneto94/multi-server:$SHA
kubectl set image deployments/client-deployment client=pauloneto94/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pauloneto94/multi-worker:$SHA