#! /bin/bash

#Sets root password for docker container and creates a nonprivellaged user.
(echo "$docker_root_pass"; echo "$docker_root_pass") | passwd
useradd -ms /bin/bash $docker_unprivileged_user
(echo $docker_unprivileged_pass; echo $docker_unprivileged_pass) | passwd $docker_unprivileged_user
