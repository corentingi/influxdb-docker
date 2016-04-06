FROM debian:jessie

MAINTAINER Corentin Gitton "<corentin.gitton@gmail.com>"

# Install ca-certificates, wget & curl and clean apt folder
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates wget curl apt-transport-https && rm -rf /var/lib/apt/lists/*

# Add influx repository
RUN curl -sL https://repos.influxdata.com/influxdb.key | apt-key add -
RUN echo "deb https://repos.influxdata.com/debian jessie stable" > /etc/apt/sources.list.d/influxdb.list

# Install influx and cleat apt folder
RUN apt-get update && apt-get install -y --no-install-recommends influxdb && rm -rf /var/lib/apt/lists/*

## The rest is inspired from Dockerfile on influxdb github repository : https://github.com/influxdata/influxdb/blob/master/Dockerfile

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE 8083 8086 8086/udp 8088 2003 4242 25826

# Generate a default config
RUN influxd config > /etc/influxdb.toml

# Use /data for all disk storage
RUN sed -i 's/dir = "\/.*influxdb/dir = "\/data/' /etc/influxdb.toml

VOLUME ["/data"]

ENTRYPOINT ["influxd", "--config", "/etc/influxdb.toml"]
