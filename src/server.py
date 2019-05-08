import netifaces as ni
from flask import Flask  
from flask import render_template

app = Flask(__name__)
data = []

def readData():
    try:
        global data
        file = open('data.txt', 'r') 
        dataB = file.read().splitlines()
        if (len(dataB) == 13):
            data = dataB
        else:
            print("Corrupted data: rereading...")
            readData()
        file.close()
    except:
        print("Cache miss: rereading...")
        readData()

@app.route("/")
def hello():  
    readData()

    return render_template('index.json',
        celltemp=data[1],
        cellpres=data[2],
        co2=data[3],
        co2abs=data[4],
        h2o=data[5],
        h2oabs=data[6],
        h2odewpoint=data[7],
        ivolt=data[8],
        co2raw=data[9],
        co2ref=data[10],
        h2oraw=data[11],
        h2oref=data[12]
    )

def get_ip_address(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])

if __name__ == "__main__":  
    ip = ni.ifaddresses('wlp2s0')
    print(ip)
    app.run()
