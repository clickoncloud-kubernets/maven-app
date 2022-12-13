#!/bin/bash
sed "s/DOCKER_TAG_REPLACE/$1/g" kubernets/maven-app.yaml > kubernets/maven-app-final.yaml
