docker build -t ayesjm/multi-client:latest -t ayesjm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ayesjm/multi-server:latest -t ayesjm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ayesjm/multi-worker:latest -t ayesjm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ayesjm/mutli-client:latest
docker push ayesjm/multi-server:latest
docker push ayesjm/multi-worker:latest

docker push ayesjm/mutli-client:$SHA
docker push ayesjm/multi-server:$SHA
docker push ayesjm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ayesjm/multi-server:$SHA
kubectl set image deployments/client-deployment client=ayesjm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ayesjm/multi-worker:$SHA