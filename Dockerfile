FROM python:3.11

RUN apt-get update && apt-get -y install git python3-pkgconfig python3-av gcc linux-libc-dev

RUN git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git /infimage
WORKDIR /infimage

RUN python -m venv /infimage/venv
RUN /infimage/venv/bin/pip install --upgrade pip
RUN /infimage/venv/bin/pip install -r /infimage/requirements.txt

COPY entry.sh /usr/local/sbin/
COPY config.json /
RUN sed -i s_/root_/outputs_ /etc/passwd

ENV IIB_CACHE_DIR=/infimage/cache
VOLUME /infimage/cache /infimage/iib_db_backup

ENTRYPOINT [ "sh", "-c", "/usr/local/sbin/entry.sh" ]
