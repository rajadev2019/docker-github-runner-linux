# base image
FROM --platform=linux/amd64 docker:dind

#input GitHub runner version argument
ARG RUNNER_VERSION=2.308.0
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author="Ranajit Koley"
LABEL Email="raja.dev2019@gmail.com"
LABEL GitHub="https://github.com/rajadev2019"
LABEL BaseImage="docker:dind"
LABEL RunnerVersion=${RUNNER_VERSION}

# update the base packages + add a non-sudo user
RUN apk update && apk upgrade && adduser -D docker

RUN apk add --no-cache bash

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
RUN apk add --update \
     # -y --no-install-recommends \
     curl nodejs wget unzip vim git jq alpine-sdk libressl-dev libffi-dev python3 py3-virtualenv python3-dev py3-pip

RUN pip install azure-cli
#RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

#RUN apt install -y apt-transport-https ca-certificates curl software-properties-common
#RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` test"
#RUN apt update -y
#RUN apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# install some additional dependencies
RUN chown -R docker ~docker && apk add bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib libgdiplus dotnet7-sdk
# /home/docker/actions-runner/bin/installdependencies.sh

# add over the start.sh script
ADD scripts/start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]