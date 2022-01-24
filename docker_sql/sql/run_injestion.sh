URL=http://192.168.0.19:8000/taxi_zone_lookup.csv
docker run -it \
  --network=pg-network \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=192.168.0.19 \
    --port=5432 \
    --db=ny_taxi \
    --table_name=taxi_zone_lookup \
    --url=${URL}