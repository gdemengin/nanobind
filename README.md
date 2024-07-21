struct with None value member 

```
docker build -t none-field ..
docker run -v $(pwd):/mnt/docker -itd --rm --name none-field none-field
docker exec -it none-field /bin/bash
cd /mnt/docker
./reproduce.sh 3.12
```
