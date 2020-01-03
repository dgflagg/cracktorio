# cracktorio
factorio tools, etc, all...


# pull & tag for a specific Factorio server version
docker pull dgflagg/cracktorio:0.17.79
docker tag dgflagg/cracktorio:0.17.79 cracktorio

# return the server help menu if no command passed as argument to container
docker run --rm cracktorio

# run interactively from a shell
docker run -it --rm --entrypoint bash cracktorio

# create a new game save
mkdir -p saves
docker run -it --rm \
    -v "$(pwd)/saves:/opt/factorio/saves" \
    cracktorio \
        --create saves/my-save.zip

# start the container
docker run -dt \
    -v "$(pwd)/saves:/opt/factorio/saves" \
    -p 34197:34197/udp \
    --name my-factorio-server \
    cracktorio \
        --start-server ./saves/my-save.zip
        
# watch the logs
docker logs --follow my-factorio-server
        
# connect to server
localhost:34197

# stop the container (along with the server)
docker stop my-factorio-server

# start the container again
docker start my-factorio-server



# local docker build
docker build --build-arg factorio_password=thefactorymustgrow -t dgflagg/cracktorio:local .


# deployment to k8s cluster
kubectl create -f k8s

# follow logs from pod
kubectl logs ${POD_NAME} --follow

# start a shell in running container
kubectl exec -it ${POD_NAME} bash


#TODO:
- cannot connect to k8s-hosted server - not sure why - can try to debug k8s networking issue
- alpine-based 'slim' image