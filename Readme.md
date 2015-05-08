This container that provides an environment to build the [Spark IM client](https://github.com/igniterealtime/Spark).



# Usage

The script `/opt/docker_files/build_spark.sh`clones the Spark repository and applies binary patches found in `/opt/sparkpatch`.


## Build  spark from trunk

```bash
docker run --name dockerbuilder -ti -u devel \
  joemat/docker-buildenv-for-spark bash /opt/docker_files/build_spark.sh
```

## Get the installers from the container

Find installers in the `~/Spark/installer` directory, copy them using docker cp:

```bash
docker cp dockerbuilder:/home/devel/Spark/installer .
```

# Create image (optional, when not using the image from dockerhub)


```bash
git clone https://github.com/joemat/docker-buildenv-for-spark.git
cd docker-buildenv-for-spark
docker build -t docker-buildenv-for-spark .
```
