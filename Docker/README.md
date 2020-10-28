# Docker_CorGAT
Docker Galaxy [CorGAT flavor](https://github.com/matteo14c/CorGAT/tree/Revision_V1) 

## How to use 
- To install Docker follow this [procedure](https://docs.docker.com/engine/install/)
- Run the container (i.e CorGAT)
  `docker run -d --privileged -p 8080:80 -p 8021:21 -p 8022:22 laniakeacloud/galaxy_corgat:19.01`
- Log into Galaxy at http://localhost:8080 username: `admin@galaxy.org` passwd: `admin`

## What to do next:
Now you have a local copy of the CorGAT Galaxy instance. Please refer to the CorGAT Galaxy [manual](https://corgat.readthedocs.io/en/latest/) for tips and instructions on how to execute your analyses  

### more info on galaxy-docker usage at https://github.com/bgruening/docker-galaxy-stable
