FROM ubuntu

RUN apt-get update; \
    apt-get install -qqy docker; \;
    apt-get clean
RUN pip install -U fig

RUN mkdir -p /opt/figapp

ONBUILD WORKDIR /opt/figapp
ONBUILD COPY fig.yml /opt/figapp
ONBUILD ENTRYPOINT docker -d & sleep 1; fig up
