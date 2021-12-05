docker build -t chrisgrigg/multi-client:latest -t chrisgrigg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chrisgrigg/multi-server:latest -t chrisgrigg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chrisgrigg/multi-worker:latest -t chrisgrigg/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chrisgrigg/multi-client:latest
docker push chrisgrigg/multi-server:latest
docker push chrisgrigg/multi-worker:latest

docker push chrisgrigg/multi-client:$SHA
docker push chrisgrigg/multi-server:$SHA
docker push chrisgrigg/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chrisgrigg/multi-server:$SHA
kubectl set image deployments/client-deployment client=chrisgrigg/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chrisgrigg/multi-worker:$SHA