DATAFILE="rho020"
cd ../src
CONV="1e-6"


ZETA="2"

RAND=""
T="8"; M="-m 320"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="16"; M="-m 640"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="24"; M="-m 960"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="32"; M="-m 1280"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv
T="64"; M="-m 2560"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_${RAND}.csv

RAND="-r"
T="8"; M="-m 320"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="16"; M="-m 640"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="24"; M="-m 960"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="32"; M="-m 1280"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
T="64"; M="-m 2560"
python sju.py -d $DATAFILE.csv ${RAND} -t ${T} ${M} -i 15000 -l 1e-${ZETA} -c ${CONV} -v 0.284895
mv sju_log.csv ../script/${DATAFILE}_t${T}_l${ZETA}_RAND.csv
