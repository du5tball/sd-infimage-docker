FROM alpine

RUN apk add python3 py3-pip git pkgconfig ffmpeg-dev gcc python3-dev libc-dev

RUN git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git /infimage
WORKDIR /infimage
RUN git -c advice.detachedHead=false checkout $(git tag --sort=v:refname|tail -n1)

RUN python -m venv /infimage/venv
RUN /infimage/venv/bin/pip install --upgrade pip
RUN /infimage/venv/bin/pip install -r /infimage/requirements.txt

COPY entry.sh /usr/local/sbin/
COPY config.json /
RUN sed -i s_/root_/outputs_ /etc/passwd

ENTRYPOINT [ "sh", "-c", "/usr/local/sbin/entry.sh" ]
