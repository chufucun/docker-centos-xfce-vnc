#!/bin/bash
service=`docker-compose ps --services| head -n 1`
docker-compose exec $service bash
