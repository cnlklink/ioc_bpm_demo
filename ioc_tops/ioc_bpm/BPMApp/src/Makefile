TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += BPMSupport

# Compile and add code to the support library
BPMSupport_SRCS += xxxRecord.c
BPMSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
BPMSupport_SRCS += dbSubExample.c
BPMSupport_SRCS += devBPMVersion.c
BPMSupport_SRCS += BPMHello.c
BPMSupport_SRCS += initTrace.c

BPMSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = BPMVersion.h
# Macro name
GENVERSIONMACRO = BPMVERSION

# Build the IOC application
PROD_IOC = BPM

# BPM.dbd will be created and installed
DBD += BPM.dbd

# BPM.dbd will include these files:
BPM_DBD += base.dbd
BPM_DBD += xxxSupport.dbd
BPM_DBD += dbSubExample.dbd
BPM_DBD += devBPMVersion.dbd
BPM_DBD += BPMHello.dbd
BPM_DBD += initTrace.dbd

# BPM_registerRecordDeviceDriver.cpp derives from BPM.dbd
BPM_SRCS += BPM_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
BPM_SRCS_DEFAULT += BPMMain.cpp
BPM_SRCS_vxWorks += -nil-

# Link in the code from our support library
BPM_LIBS += BPMSupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into BPMSupport
    sncExample_SNCFLAGS += +r
    BPM_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    BPMSupport_SRCS += sncExample.stt
    BPMSupport_LIBS += seq pv
    BPM_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    BPM_LIBS += qsrv
    BPM_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    BPM_DBD += PVAServerRegister.dbd
    BPM_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
BPM_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devBPMVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
