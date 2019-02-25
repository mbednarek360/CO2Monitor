import netifaces as ni
from flask import Flask  
from flask import render_template

app = Flask(__name__)

@app.route("/")
def hello():  
    file = open('data.json', 'r') 
    data = file.read()
    file.close()
    return render_template('index.html', co2=data)

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