docker build -t yadjanor/multi-client:latest -t yadjanor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yadjanor/multi-server:latest -t yadjanor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yadjanor/multi-worker:latest -t yadjanor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yadjanor/multi-client:latest
docker push yadjanor/multi-server:latest
docker push yadjanor/multi-worker:latest

docker push yadjanor/multi-client:$SHA
docker push yadjanor/multi-server:$SHA
docker push yadjanor/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yadjanor/multi-server:$SHA
kubectl set image deployments/client-deployment client=yadjanor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yadjanor/multi-worker:$SHA
