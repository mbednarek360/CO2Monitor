mkdir data
google-drive-ocamlfuse data

sh log.sh $1 data/CO2

fusermount -u data
rmdir data