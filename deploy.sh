docker build -t jlnzllc/multi-client:latest -t jlnzllc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jlnzllc/multi-server:latest -t jlnzllc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jlnzllc/multi-worker:latest -t jlnzllc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jlnzllc/mutli-client:latest
docker push jlnzllc/multi-server:latest
docker push jlnzllc/multi-worker:latest

docker push jlnzllc/mutli-client:$SHA
docker push jlnzllc/multi-server:$SHA
docker push jlnzllc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jlnzllc/multi-server:$SHA
kubectl set image deployments/client-deployment client=jlnzllc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jlnzllc/multi-worker:$SHA