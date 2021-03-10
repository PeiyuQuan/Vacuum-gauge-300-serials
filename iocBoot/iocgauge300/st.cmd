#!../../bin/linux-x86_64/gauge300

#- You may have to change gauge300 to something else
#- everywhere it appears in this file

< envPaths

epicsEnvSet("PREFIX", "UWXRD:300s_gauge:")
epicsEnvSet("PORT", "serial1")
epicsEnvSet (STREAM_PROTOCOL_PATH, "$(TOP)/gauge300App/Db")

## Register all support components
dbLoadDatabase "${TOP}/dbd/gauge300.dbd"
gauge300_registerRecordDeviceDriver pdbbase


drvAsynSerialPortConfigure("serial1", "ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")
#asynSetTraceMask("serial1", 0, ERROR|DRIVER|FLOW)
## Load record instances
#dbLoadRecords("db/xxx.db","user=uwchamber")
dbLoadRecords("$(TOP)/gauge300App/Db/300s_gauge.db","P=$(PREFIX),PORT=serial1")



iocInit

## Start any sequence programs
#seq sncxxx,"user=uwchamber"
