run:
	docker run --runtime=nvidia --privileged -it --rm --net=host -v /home/ryonakabayashi/lgsvlsimulator-linux64-master-182:/lg2 -v /home/ryonakabayashi/x11-docker/lgsvlsimulator-linux64-2019.05:/lg --name gl-test gl-test
run-bash:
	docker run --runtime=nvidia --privileged -it --rm -p 8080:8080 -p 5900:5900 -v /home/ryonakabayashi/lgsvlsimulator-linux64-master-182:/lg2 -v /home/ryonakabayashi/x11-docker/lgsvlsimulator-linux64-2019.05:/lg --name gl-test gl-test bash

build:
	nvidia-docker build -t gl-test .

exec:
	docker exec -it gl-test bash
