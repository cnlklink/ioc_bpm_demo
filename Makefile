IMAGE_NAME	= cnlklink/docker_ioc_bpm

.DEFAULT: build_image

.PHONY: run

build_image:
	docker build -t $(IMAGE_NAME):latest .

run:
	docker run --rm -it -d --user $(id -u):$(id -g) --mount type=bind,source=/home/jdiamond/workspace/ioc_bpm_demo/ioc_tops,target=/epics/iocs --name bpm -w /epics/iocs/ioc_bpm/ioc
Boot/iocBPM pklaus/epics_base:7.0.4_debian ./st.cmd
