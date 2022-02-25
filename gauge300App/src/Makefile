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
LIBRARY_IOC += gauge300Support

# Compile and add code to the support library
gauge300Support_SRCS += xxxRecord.c
gauge300Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
gauge300Support_SRCS += dbSubExample.c
gauge300Support_SRCS += devgauge300Version.c
gauge300Support_SRCS += gauge300Hello.c
gauge300Support_SRCS += initTrace.c

gauge300Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = gauge300Version.h
# Macro name
GENVERSIONMACRO = gauge300VERSION

# Build the IOC application
PROD_IOC = gauge300

# gauge300.dbd will be created and installed
DBD += gauge300.dbd

# gauge300.dbd will include these files:
gauge300_DBD += base.dbd
gauge300_DBD += xxxSupport.dbd
gauge300_DBD += dbSubExample.dbd
gauge300_DBD += devgauge300Version.dbd
gauge300_DBD += gauge300Hello.dbd
gauge300_DBD += initTrace.dbd
gauge300_DBD += asyn.dbd
gauge300_DBD += drvAsynIPPort.dbd
gauge300_DBD += drvAsynSerialPort.dbd
gauge300_DBD += calc.dbd
gauge300_DBD += stream-scalcout.dbd
gauge300_DBD += stream.dbd
gauge300_DBD += as.dbd
gauge300_DBD += asSupport.dbd
# gauge300_registerRecordDeviceDriver.cpp derives from gauge300.dbd
gauge300_SRCS += gauge300_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
gauge300_SRCS_DEFAULT += gauge300Main.cpp
gauge300_SRCS_vxWorks += -nil-

# Link in the code from our support library
gauge300_LIBS += gauge300Support
gauge300_LIBS += asyn
gauge300_LIBS += calc
gauge300_LIBS += autosave
gauge300_LIBS += stream
# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into gauge300Support
    sncExample_SNCFLAGS += +r
    gauge300_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    gauge300Support_SRCS += sncExample.stt
    gauge300Support_LIBS += seq pv
    gauge300_LIBS += seq pv

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
    gauge300_LIBS += qsrv
    gauge300_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    gauge300_DBD += PVAServerRegister.dbd
    gauge300_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
gauge300_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devgauge300Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
