docker build -t stephengrider/multi-client:latest -t dockerid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t dockerid/multi-server:$SHA-f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t dockerid/multi-worker:$SHA-f ./worker/Dockerfile ./worker

docker push dockerid/multi-client:latest
docker push dockerid/multi-server:latest
docker push dockerid/multi-worker:latest

docker push dockerid/multi-client:$SHA
docker push dockerid/multi-server:$SHA
docker push dockerid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockerid/multi-server:$SHA
kubectl set image deployments/client-deployment server=dockerid/multi-client:$SHA
kubectl set image deployments/worker-deployment server=dockerid/multi-worker:$SHA