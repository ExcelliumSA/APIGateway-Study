# APIGateway-Study

> :construction: Work in progress, see file [working-note.pdf](working-note.pdf) for status.

Contains the materials used for the blog post about the testing of the API Gateway configuration.

# Blog post link

XXX

# Execute the lab

> Once launched, the API Gateway ([APIMAN](https://www.apiman.io)) web UI will be available on http://localhost:8080/apimanui/api-manager with creds `admin` / `admin123!`.

> Keycloack authentication part will be available on http://localhost:8080/auth with the same creds.

> Lab requires [docker and docker-compose](https://docs.docker.com/get-docker/) as well as a Internet connection.

*Step 1*

Download a copy of this repository.

*Step 2:*

Use the following set of commands:

```powershell
PS> docker-compose up --build --detach
PS> docker run --rm -it righettod/demo-test-apigtw /bin/bash
$ curl -Lsk https://[DOCKER_HOST_IP]:8443/apimanui/api-manager | grep -ic "apiman"
# Ensure that result of the command above is different from zero. Otherwise, wait a few seconds, and relaunch the command...
$ bash run.sh [DOCKER_HOST_IP]:8443
$ exit
PS> docker-compose down
PS> docker ps -a
```

# Demonstration

Take a look at [this video](demo.mp4).
