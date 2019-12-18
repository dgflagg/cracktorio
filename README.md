# cracktorio
factorio tools, etc, all...


# local docker build
docker build --build-arg FACTORIO_PASSWORD=thefactorymustgrow -t dgflagg/cracktorio:local .

# return the server help menu if no command passed as argument to container
docker run --rm dgflagg/cracktorio:local

# run interactively from a shell
docker run -it --rm --entrypoint bash dgflagg/cracktorio:local


# create a new game save
mkdir -p saves
docker run -it --rm \
    -v "$(pwd)/saves:/opt/factorio/saves" \
    dgflagg/cracktorio:local \
        --create saves/my-save.zip

# start the container
docker run -dt \
    -v "$(pwd)/saves:/opt/factorio/saves" \
    -p 34197:34197/udp \
    --name my-factorio-server \
    dgflagg/cracktorio:local \
        --start-server ./saves/my-save.zip
        
# watch the logs
docker logs --follow my-factorio-server
        
# connect to server
localhost:34197

# stop the container (along with the server)
docker stop my-factorio-server

# start the container again
docker start my-factorio-server