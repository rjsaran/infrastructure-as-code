include .env
export $(shell sed 's/=.*//' .env)

build-bastion:
	cd bastion && \
	packer build build.json && \
	cd -

build-jenkins-master:
	cd jenkins-master && \
	packer build build.json && \
	cd -

build-jenkins-slave:
	cd jenkins-slave && \
	packer build build.json && \
	cd -

build-docker-swarm:
	cd docker-swarm && \
	packer build build.json && \
	cd -