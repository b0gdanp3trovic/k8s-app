docker build -t bogdanb0da/multi-client:latest -t bogdanb0da/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bogdanb0da/multi-server:latest -t bogdanb0da/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bogdanb0da/multi-worker:latest -t bogdanb0da/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bogdanb0da/multi-client:latest
docker push bogdanb0da/multi-server:latest
docker push bogdanb0da/multi-worker:latest

docker push bogdanb0da/multi-client:$SHA
docker push bogdanb0da/multi-server:$SHA
docker push bogdanb0da/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bogdanb0da/multi-server:$SHA
kubectl set image deployments/client-deployment client=bogdanb0da/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bogdanb0da/multi-server:$SHA

