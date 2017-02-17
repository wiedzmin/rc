#!/bin/bash

echo "Removing existing containers (system, portage)"
docker rm -v gentoo portage
echo "Recreating portage container"
docker create -v /usr/portage --name portage gentoo/portage
echo "Running system"
docker run --volumes-from portage -v /home/octocat/workspace/configs/rc:/rc --name gentoo -it gentoo/stage3-amd64 /bin/bash
