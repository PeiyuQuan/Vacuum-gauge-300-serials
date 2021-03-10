TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = gauge300
# gauge300.dbd will be created and installed
DBD += gauge300.dbd

# gauge300.dbd will be made up from these files:
gauge300_DBD += base.dbd

# Include dbd files from all support applications:
#gauge300_DBD += xxx.dbd
gauge300_DBD += asyn.dbd
gauge300_DBD += calc.dbd
gauge300_DBD += stream.dbd
gauge300_DBD += stream-scalcout.dbd
gauge300_DBD += drvAsynIPPort.dbd
gauge300_DBD += drvAsynSerialPort.dbd
# Add all the support libraries needed by this IOC
#gauge300_LIBS += xxx
gauge300_LIBS += calc
gauge300_LIBS += asyn
gauge300_LIBS += stream
# gauge300_registerRecordDeviceDriver.cpp derives from gauge300.dbd
gauge300_SRCS += gauge300_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
gauge300_SRCS_DEFAULT += gauge300Main.cpp
gauge300_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#gauge300_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
gauge300_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

