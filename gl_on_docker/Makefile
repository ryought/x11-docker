run:
	docker run --runtime=nvidia --privileged -it --rm -p 8181:8181 -v /home/ryonakabayashi/x11-docker/lgsvlsimulator-linux64-2019.05:/lg --name gl-test gl-test bash

build:
	nvidia-docker build -t gl-test .
