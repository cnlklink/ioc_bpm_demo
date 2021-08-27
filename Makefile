IMAGE_NAME	= cnlklink/docker_ioc_bpm

.DEFAULT: image

.PHONY: run stop test

image:
	docker build -t $(IMAGE_NAME):latest .

run:
	docker run --rm \
		-it -d --user $(id -u):$(id -g) \
		--mount type=bind,source=$(shell pwd)/ioc_tops,target=/epics/iocs \
		--name bpm \
		-w /epics/iocs/ioc_bpm/iocBoot/iocBPM \
		pklaus/epics_base:7.0.4_debian \
		./st.cmd

stop:
	docker stop bpm

test:
	@docker run --rm -it -d --name test $(IMAGE_NAME); sleep 1
	@docker run -it --rm pklaus/catools pvget BPM:aiExample | ./validate.pl
	@docker stop test
