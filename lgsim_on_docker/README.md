it runs LG simulator on docker container
but maybe it uses X11 server (and GPU) running on host
so it cannot be used when deployed on AWS as a container without direct access to host machine.
