#!/bin/env bash

docker run --env PASSWORD=mypasswordamc \
--publish 8787:8787 \
--detach \
--name amc-celltyping \
-v /mnt/rreal/RDS/DATA:/home/rstudio/DATA/:ro \
-v /mnt/rreal/RDS/acarrasco/ANALYSES_WORKSPACE/CELLTYPING_PROJECT/CELLTYPING_V2:/home/rstudio/celltyping_wd \
amc-celltyping:latest

