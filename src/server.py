import netifaces as ni
from flask import Flask  
from flask import render_template

app = Flask(__name__)

@app.route("/")
def hello():  
    file = open('data.txt', 'r') 
    data = file.read().splitlines()
    file.close()

    return render_template('index',
        celltemp=data[0],
        cellpres=data[1],
        co2=data[2],
        co2abs=data[3],
        h2o=data[4],
        h2oabs=data[5],
        h2odewpoint=data[6],
        ivolt=data[7],
        co2raw=data[8],
        co2ref=data[9],
        h2oraw=data[10],
        h2oref=data[11]
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
    app.run(host="172.16.42.213")