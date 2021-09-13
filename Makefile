default: start

start:
	docker-compose -f ./config/docker/docker-compose.yml up

down:
	docker-compose -f ./config/docker/docker-compose.yml down

update_source_configs:
	mkdir source && curl https://codeload.github.com/dgraph-io/dgraph/tar.gz/master | tar -xz --strip=2 -C source dgraph-master/contrib/config 

update_helm_charts:
	mkdir source && curl https://codeload.github.com/dgraph-io/charts/tar.gz/master | tar -xz --strip=2 -C source
	
create_cluster:
	terraform init && terraform plan -target=module.aws && terraform apply -target=module.aws

provision_cluster:
	helm repo add dgraph https://charts.dgraph.io && helm install "latest" dgraph/dgraph

teardown_cluster:
	helm delete "latest" && kubectl delete pvc --selector release=my-release

