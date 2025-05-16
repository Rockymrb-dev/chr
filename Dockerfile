docker run -d \
    --name=firefox \
    -p 8080:5800 \
    -v /docker/appdata/firefox:/config:rw \
    jlesage/firefox
