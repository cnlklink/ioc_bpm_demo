# ioc_bpm_demo
Demonstration of a Docker-based development workflow for a BPM IOC.

Some points of interest:
* `Dockerfile` shows an example of how to construct a new Docker image that builds upon the EPICS base image.
* `Makefile` contains basic example `docker` commands that build, run and test the IOC.
* `.github/workflows/main.yml` demonstrates how to launch the IOC inside a container and do some test `pvget`s as part of a GitHub Actions workflow.
