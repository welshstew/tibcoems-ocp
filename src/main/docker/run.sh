docker run -Pitd --restart=always \
  -v /Users/swinches/docker/ems/data:/var/opt/ems/data\
  -v /Users/swinches/certs:/var/opt/ems/certs \
  -p 61222:7222 \
  -p 61243:7243 \
  --name ems-local \
   ems:1-SNAPSHOT
