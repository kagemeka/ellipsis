docker run \
  -itd \
  --runtime=nvidia \
  --name=ellipsis \
  --privileged=true \
  --net=host \
  --ipc=host \
  --env DISPLAY=$DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/dri:/dev/dri:rwm \
  kagemeka/ellipsis

xhost + 