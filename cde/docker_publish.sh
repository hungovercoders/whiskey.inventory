docker login ## login to docker hub
docker tag whiskeyapi:latest hungovercoders/whiskeyapi:latest
docker build -t hungovercoders/whiskeyapi:latest . ## build image and you can use tag to add version
docker push hungovercoders/whiskeyapi:latest ## push to docker hub with tag of version