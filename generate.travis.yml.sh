#!/bin/bash


echo 'language: c'
echo ''
echo 'services:'
echo '  - docker'
echo ''
echo 'jobs:'
echo '  include:'
for ARCH in $(./generate.Dockerfile.sh list)
do
	TAG="cfdgo/tclb:$ARCH-nompi"
        echo '    - stage: build base'
        echo '      script:'
        echo '        - echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USER" --password-stdin'
        echo "        - ./generate.Dockerfile.sh $ARCH | docker build --pull --tag $TAG -"
        echo "        - docker push $TAG"
        echo "      name: $ARCH"
done
for ARCH in $(./generate.Dockerfile.sh list)
do
	for MPITAG in $(./generate.Dockerfile.sh $ARCH list)
	do
		TAG="cfdgo/tclb:$ARCH-$MPITAG"
                echo '    - stage: build with MPI'
                echo '      script:'
                echo '        - echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USER" --password-stdin'
                echo "        - ./generate.Dockerfile.sh $ARCH $MPITAG | docker build --pull --tag $TAG -"
                echo "        - docker push $TAG"
                echo "      name: $ARCH with $MPITAG"
	done
done
