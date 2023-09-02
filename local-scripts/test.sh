# This is for keeping a note on the commands used to troubleshoot
# but all the commands may not have been required

dscl . list /groups          
groups

cat ./.docker/run/docker.sock   # gives error as it is socket   
ls -lrth /var/run/docker.sock

chmod 666 /var/run/docker.sock

service --status-all 
service docker start

docker run --privileged docker:dind