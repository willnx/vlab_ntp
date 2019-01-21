clean:
	-docker rm `docker ps -a -q`
	-docker rmi `docker images -q --filter "dangling=true"`

images:
	docker build -t willnx/vlab-ntp .

up:
	docker-compose -p vlabNTP up --abort-on-container-exit
