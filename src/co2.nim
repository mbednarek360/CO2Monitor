import serial/serialport
import osproc
import strutils

#[
    Sequence Values:

    0: celltemp
    1: cellpres
    2: co2
    3: co2abs
    4: h2o
    5: h2oabs
    6: h2odewpoint
    7: ivolt
    8: co2 (raw)
    9: co2ref (raw)
    10: h2o (raw)
    11: h2oref (raw)
]#

proc parsePacket(packet: string): seq[string] =
    var outp: seq[string] = @[]
    let data = packet.split("<")
    for i in data:
        if not i.contains("/"):
                let info = i.split(">")
                if (len(info) > 1):
                    if (info[1] != ""):
                        outp.add(info[1])
    return outp

proc handlePacket(packet: string) =
    let data = parsePacket(packet)
    echo(data)

proc startRead() =
    let port = newSerialPort("/dev/ttyUSB0")
    port.open(9600, Parity.None, 8, StopBits.One)

    var receiveBuffer = newString(1024)
    var packet = ""
    while true:
        let numReceived = port.read(receiveBuffer)
        packet = (packet & receiveBuffer[0 ..< numReceived])
        if (packet.contains("</li840>")):
            handlePacket(packet)
            packet = ""

startRead()