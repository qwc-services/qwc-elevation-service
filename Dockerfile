FROM sourcepole/qwc-uwsgi-base:alpine-v2026.01.06

WORKDIR /srv/qwc_service
ADD pyproject.toml uv.lock ./

RUN \
    apk add --no-cache --update --virtual runtime-deps py3-gdal && \
    uv venv --system-site-packages && \
    uv sync --frozen && \
    uv cache clean

ADD src .

ENV SERVICE_MOUNTPOINT=/elevation
