# APIGateway-Study

Contains the materials used for the blog post about the testing of the API Gateway configuration.

# Blog post link

https://excellium-services.com/2021/09/20/how-to-automatically-validate-the-configuration-of-your-api-gateway/

# Study note

> :information_source: Download the PDF file to enable the links inside the PDF.

See file [study-note.pdf](study-note.pdf) to access to the full study note gathered and used for the demo as well as the blog post.

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
# Ensure that result of the command above is different from zero. 
# Otherwise, wait a few seconds, and relaunch the command...
# If you only want to initialize the API Gateway without running the demo 
# then type: python import-config.py [DOCKER_HOST_IP]:8443 
$ bash run.sh [DOCKER_HOST_IP]:8443
$ exit
PS> docker-compose down
PS> docker ps -a
```

# Manually call the lab API

> Use `pip install httpie` to install the [http client used](https://httpie.io/docs).

## Public API

Call syntax - replace `[BIN_ID]` by the https://requestbin.net BIN identifier:

```shell
# Call raising a CORS origin not allowed error
$ http --verify=no "https://localhost:8443/apiman-gateway/XLM/bin/1.0/[BIN_ID]?a=b" Origin:https://localhost:8442
...
# Valid call
$ http --verify=no "https://localhost:8443/apiman-gateway/XLM/bin/1.0/[BIN_ID]?a=b" Origin:https://localhost:8443
...
```

## Published API

Call syntax:

```shell
# Call raising an missing authentication error
$ http --verify=no "https://localhost:8443/apiman-gateway/XLM/blog/1.2/todos/1?apikey=d09e70b2-2abc-47d8-9168-80878e662e6a"
...
# Successful call
$ http --verify=no -a user:password "https://localhost:8443/apiman-gateway/XLM/blog/1.2/todos/1?apikey=d09e70b2-2abc-47d8-9168-80878e662e6a"
...
```

# Demonstration

Take a look at [this video](demo.mp4).
