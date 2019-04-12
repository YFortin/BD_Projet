export BACK_END_IP=$(docker-machine ip)
echo "IP: $BACK_END_IP"
echo "module.exports = {
    BASE_URL: \"$BACK_END_IP\"
}" > ./front-end/src/js/url.js
docker-compose build && docker-compose up