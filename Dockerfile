FROM openjdk:27-ea-jdk-slim

LABEL maintainer="Satoshi Yamamoto"
LABEL description="epubcheck Docker Image"
LABEL version="2026-09-24"
LABEL homepage="https://www.shoeisha.co.jp"
LABEL repository="https://github.com/YamamotoAtShoeisha/docker_epubcheck"

WORKDIR /app
RUN apt update; apt upgrade -y; apt install wget unzip -y; \
    wget https://github.com/w3c/epubcheck/releases/download/v5.4.0/epubcheck-5.4.0.zip; unzip epubcheck-5.4.0.zip; rm epubcheck-5.4.0.zip; mv epubcheck-5.4.0 /app/target; \
    echo '#!/bin/bash\n java -jar /app/target/epubcheck.jar "${@:1}"\n' > entrypoint.sh

RUN chmod +x entrypoint.sh

ENV DATA_PATH=/data
WORKDIR ${DATA_PATH}
VOLUME ${DATA_PATH}

ENTRYPOINT [ "/app/entrypoint.sh" ]