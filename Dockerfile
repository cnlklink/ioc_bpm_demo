FROM pklaus/epics_base:7.0.4_debian

LABEL "maintainer"="jdiamond@fnal.gov"

USER root

# Copy IOC files into the container
ADD ioc_tops/ioc_bpm /epics/iocs/ioc_bpm
RUN chown -R scs:users /epics/iocs/ioc_bpm

# Build IOC
WORKDIR /epics/iocs/ioc_bpm

USER scs

RUN make

# Start the IOC when the container starts
WORKDIR /epics/iocs/ioc_bpm/iocBoot/iocBPM
CMD ["./st.cmd"]
