cd /Users/raja/Data/WORK/Code/docker-github-runner-linux
pwd
docker build --build-arg RUNNER_VERSION=2.308.0 --tag docker-github-runner-linux .
docker run --name gitrunner -it --privileged=true -e GH_TOKEN='' -e GH_OWNER='rajadev2019' -e GH_REPOSITORY='docker-github-runner-linux' -d docker-github-runner-linux
#docker run -e GH_TOKEN='' -e GH_OWNER='rajadev2019' -e GH_REPOSITORY='docker-github-runner-linux' -d docker-github-runner-linux
#docker run --name dockerdind -v /var/run/docker.sock:/var/run/docker.sock -ti docker:dind