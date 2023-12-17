docker volume create pg_volume_atomhack

#docker network create net_atomhack

docker run --rm -d \
    --name pg_atomhack \
    -e POSTGRES_PASSWORD=atomhack2023 \
    -e POSTGRES_USER=pg_admin \
    -e POSTGRES_DB=pg_atomhack \
    -v pg_volume_atomhack:/var/lib/postgresql.data \
#  --net = net_atomhack \
    postgres

    