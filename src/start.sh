nim c co2.nim
./co2 &
python3 server.py $(hostname -I)
killall co2
rm cache co2