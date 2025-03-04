This is a docker container for https://github.com/zanllp/sd-webui-infinite-image-browsing. It can be run via `docker run -d --name iib -p 8080:8080 -v /path/to/sdoutput/txt2img:/outputs du5tball/iib:latest`. However, I don't regularly build images, so you are encouraged to build your own instead! This can be done via `docker build . -t du5tball/iib:latest` (you can change the tag to whatever you wish).

Or if you use docker-compose, which gives you the advantage of building and autotagging the image:

```yaml
services:
  iib:
    build: https://github.com/du5tball/sd-infimage-docker.git#main
    restart: always
    ports:
      - 8080:8080
    volumes:
      - /path/to/sdoutput:/outputs:ro
      - /path/to/config.json:/config.json:ro                    # if you want to use your own iib-config
      - /path/to/iib.db:/infimage/iib.db                        # see note below
      - /path/to/backup:/infimage/iib_db_backup
      - /path/to/cache:/infimage/cache
    environment:
      TZ: Europe/Berlin
      EXTRA_OPTIONS: --update_image_index                       # options get appended to iib
```

The "iib.db"-volume must be a file and created manually BEFORE you run the container, else every time the container is updated, it rescans *all* images. For Linux, this can be done via `touch iib.db`, for Windows `type con > iib.db`. Ignore the error, all we want is an empty file. For the curious, we're testing for the filetype of a file that, for historical reasons, can never exist in windows.