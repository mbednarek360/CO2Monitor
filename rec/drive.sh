mkdir data
google-drive-ocamlfuse data

sh log.sh $1 data/CO2

killall google-drive-oc
rmdir data