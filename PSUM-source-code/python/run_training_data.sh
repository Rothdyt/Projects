DATAFILE="training"
cd ../src
CONV="1e-6"


ZETA="2"

RAND=""
T="1"; M="-m 40"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="4"; M="-m 160"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="8"; M="-m 320"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="32"; M="-m 1280"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
RAND="-r"
T="1"; M="-m 40"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="4"; M="-m 160"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="8"; M="-m 320"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="32"; M="-m 1280"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv


ZETA="6"

RAND=""
T="1"; M="-m 40"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="4"; M="-m 160"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="8"; M="-m 320"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="32"; M="-m 1280"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
RAND="-r"
T="1"; M="-m 40"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="4"; M="-m 160"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="8"; M="-m 320"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="32"; M="-m 1280"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 1000000 -l 1e-${ZETA} -c ${CONV}
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
