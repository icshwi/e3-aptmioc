require adpico8,1.0.0
require aptmioc,1.0.0

# SYSTEM: BD system that this IOC controls
epicsEnvSet("SYSTEM",                       "BD-APTM1")
# LOC: short name used in PV names
epicsEnvSet("LOC",                          "APTM1")
epicsEnvSet("ACQ_UNIT1",                    "AMC1")
#epicsEnvSet("ACQ_UNIT2",                    "AMC2")
#epicsEnvSet("ACQ_UNIT3",                    "AMC3")
# ACQ_SAMPLES: maximum number of samples to acquire
#              100k per channel per rate (14 Hz), this is highly conservative
#              when looking at ~10Msps for 6ms of pulse length.
epicsEnvSet("ACQ_SAMPLES",                  "100000")
# HOLD_SAMPLES: maximum number of timeseries data
#               6 pulses, make sure to follow ACQ_SAMPLES changes
epicsEnvSet("HOLD_SAMPLES",                 "600000")
# TREND_SAMPLES: maximum number of pulse statistics in trending PVs
epicsEnvSet("TREND_SAMPLES",                "1000")

# EPICS_CA_MAX_ARRAY_BYTES: 10 MB max CA request
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES",     "10000000")




errlogInit(20000)



# common settings
epicsEnvSet("XSIZE",         "$(ACQ_SAMPLES)")
epicsEnvSet("YSIZE",         "1")
epicsEnvSet("QSIZE",         "20")
epicsEnvSet("NCHANS",        "2048")
epicsEnvSet("CBUFFS",        "500")
epicsEnvSet("MAX_THREADS",   "4")
# PREFIX is common for all boards
epicsEnvSet("PREFIX",        "$(LOC):")

# board 1 : channels 1 - 8
epicsEnvSet("PICODEV",       "/dev/amc_pico_0000:05:00.0")
epicsEnvSet("PORT",          "$(ACQ_UNIT1)")
epicsEnvSet("ACQ_UNIT",      "$(ACQ_UNIT1)")
< adpico8.cmd


# controls for all boards
dbLoadRecords("aptm.template",        "P=$(PREFIX),R=SYS:,ACQ1=$(ACQ_UNIT1):,ACQ2=$(ACQ_UNIT2):,ACQ3=$(ACQ_UNIT3):,MAX_SAMPLES=$(ACQ_SAMPLES)")

#dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(PREFIX)")


