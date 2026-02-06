[![](https://github.com/qwc-services/qwc-elevation-service/workflows/build/badge.svg)](https://github.com/qwc-services/qwc-elevation-service/actions)
[![docker](https://img.shields.io/docker/v/sourcepole/qwc-elevation-service?label=Docker%20image&sort=semver)](https://hub.docker.com/r/sourcepole/qwc-elevation-service)

QWC Elevation Service
=====================

Returns elevations.


Configuration
-------------

The static config files are stored as JSON files in `$CONFIG_PATH` with subdirectories for each tenant,
e.g. `$CONFIG_PATH/default/*.json`. The default tenant name is `default`.

### Elevation Service config

* [JSON schema](schemas/qwc-elevation-service.json)
* File location: `$CONFIG_PATH/<tenant>/elevationConfig.json`

Example:
```json
{
  "$schema": "https://raw.githubusercontent.com/qwc-services/qwc-elevation-service/master/schemas/qwc-elevation-service.json",
  "service": "elevation",
  "config": {
    "elevation_dataset": "/vsicurl/https://data.sourcepole.com/srtm_1km_3857.tif"
  }
}
```

Example with multiple datasets:
```json
{
  "$schema": "https://raw.githubusercontent.com/qwc-services/qwc-elevation-service/master/schemas/qwc-elevation-service.json",
  "service": "elevation",
  "config": {
    "elevation_datasets": [
      {
        "name": "SRTM",
        "dataset_path": "/vsicurl/https://data.sourcepole.com/srtm_1km_3857.tif"
      },
      {
        "name": "Local",
        "dataset_path": "/dtm_local.tif"
      }
    ]
  }
}
```

### Environment variables

Config options in the config file can be overridden by equivalent uppercase environment variables.

Run locally
-----------

Install dependencies and run:

    # Install python3-gdal in system package
    apt/dnf install python3-gdal

    # Setup venv with --system-site-packages for python3-gdal
    uv venv --system-site-packages .venv

    export CONFIG_PATH=<CONFIG_PATH>
    uv run src/server.py

To use configs from a `qwc-docker` setup, set `CONFIG_PATH=<...>/qwc-docker/volumes/config`.

Set `FLASK_DEBUG=1` for additional debug output.

Set `FLASK_RUN_PORT=<port>` to change the default port (default: `5000`).

API documentation:

    http://localhost:$FLASK_RUN_PORT/api/

Docker usage
------------

The Docker image is published on [Dockerhub](https://hub.docker.com/r/sourcepole/qwc-elevation-service).

See sample [docker-compose.yml](https://github.com/qwc-services/qwc-docker/blob/master/docker-compose-example.yml) of [qwc-docker](https://github.com/qwc-services/qwc-docker).

