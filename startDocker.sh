export BACK_END_IP=$(docker-machine ip)
echo "IP: $BACK_END_IP"
docker-compose build && docker-compose up