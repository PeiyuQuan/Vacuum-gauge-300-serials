#!../../bin/linux-x86_64/gauge300


< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/gauge300.dbd"
gauge300_registerRecordDeviceDriver pdbbase

epicsEnvSet("STREAM_PROTOCOL_PATH","${TOP}/gauge300App/Db")
epicsEnvSet("PREFIX", "SLAC:Gauge300s:")
epicsEnvSet("PORT", "serial1")

## Load record instances
#drvAsynSerialPortConfigure("portName","ttyName",priority,noAutoConnect,noProcessEosIn)
#asynSetOption("portName",addr,"Key","value")

drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")

dbLoadRecords("${TOP}/gauge300App/Db/gauge300s.db","P=$(PREFIX),M=kjl1:,PORT=serial1")
#dbLoadRecords("${TOP}/gauge300App/Db/gauge300s.db","P=$(PREFIX),M=kjl2:,PORT=serial1")
#dbLoadRecords("${TOP}/gauge300App/Db/gauge300s.db","P=$(PREFIX),M=kjl3:,PORT=serial1")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1, PORT=serial1, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(PREFIX)")


cd "${TOP}/iocBoot/${IOC}"
iocInit
