# InfluxDB

Simple InfluxDB image with all port exposed and all disk storage in a /data volume.

Building the image:
```bash
docker build -t corentingi/influxdb .
```

Running this image:
```bash
docker run -d --name influxdb -p 8083:8083 -p 8086:8086 -v influxdb:/data corentingi/influxdb
```
