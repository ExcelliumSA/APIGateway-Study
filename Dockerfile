# docker build --rm -t righettod/demo-test-apigtw .
# docker run -it righettod/demo-test-apigtw /bin/bash
FROM alpine:latest
RUN apk add --no-cache bash curl jq python3 py3-pip wget
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip install requests python-keycloak
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN mkdir /work
ENV PATH "$PATH:/work"
WORKDIR /work
RUN wget -q -O /work/venom https://github.com/ovh/venom/releases/download/v1.0.0-rc.4/venom.linux-amd64
RUN cd /work;chmod +x venom;./venom update;echo "Force RC to 0."
COPY multi-request-sender.py import-config.py public-api-test-plan.yaml published-api-test-plan.yaml api-manager-export.json run.sh /work/
RUN chown -R appuser:appgroup /work;chmod +x /work/*
USER appuser