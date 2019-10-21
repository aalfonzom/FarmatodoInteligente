import paho.mqtt.client as mqtt
import time
import datetime

client = mqtt.Client()
broker = "localhost"
topic = "Farmatodo/Camara/#" #topico escogido
QOS = 2
date = datetime.datetime.now()

#metodos generales de los subcriptotes 
def on_connect(client, userdata, flags, rc):
    if(rc == 0):
        print("Se ha conectado al Cliente")
        rc = client.subscribe(topic, QOS)

def on_message(client, userdata, msg):
    print("\n---------------------------------------------------")
    print("Mensaje         : " +str(msg.payload.decode()))
    print("Qos del mensaje : "+str(msg.qos))
    print("Tópico          : "+str(msg.topic))
    print("Hora del mensaje: "+str(date))
    print("---------------------------------------------------\n")

client.on_connect   =   on_connect
client.on_message = on_message

client.connect(broker)

time.sleep(2)
client.loop_forever()