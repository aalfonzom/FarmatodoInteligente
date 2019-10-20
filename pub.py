import paho.mqtt.client as mqtt
import time
import random
import datetime
import psycopg2 as psy

conn=psy.connect(host = 'localhost', user= 'postgres', password ='miravila1', dbname= 'FarmatodoInteligente')

def createMacAddress():    
    mac_Address  = random.randrange(100000000000,999999999999)
    return mac_Address

def createGenter():
    list  = [M,F]
    gender = random.choice(list)
    return gender

def createAge():
    age = random.randint(1,100)
    return age

def createId():
    id = random.randint(1, 1000000)
    return id

def hasPhone():
    phone = random.randint(0,5)
    if(phone != 3):
        macAddres = createMacAddress()
        return macAddres

    else:
        return '0'

# Defino variables
client = mqtt.Client("Cliente")
broker = "localhost"
exitFlag = True
date = datetime.datetime.now()

# Funcion que se ejecuta cuando se publica data.
def on_publish(client, userdata, mid):
    print("\n------------------------------------------")
    print("Hora del mensaje : "+str(date))
    print("Mensaje Publicado: "+str(mid))


# Funcion que se ejecuta cuando ocurre la conexion
def on_connect(client, userdata, flags, rc):
    global exitFlag
    if(rc == 0):  # si la coneccion es exitosa
        print("\n------------------------------------------")
        print("El publicador se ha conectado")
        print("Se ha conectado a la Farmacia. Codigo:"+str(rc))
        exitFlag = False


# Funcion que se ejecuta al desconectarse
def on_disconnect(pvtClient, userdata, rc):
    print("Razon de la desconeccion: " + str(rc))
    client.disconnect()


# Asocio las funciones a los callbacks
client.on_publish = on_publish
client.on_connect = on_connect
client.on_disconnect = on_disconnect

# Establezco la coneccion
client.connect(broker)

# Empiezo el loop y doy tiempo para la conexion
client.loop_start()
time.sleep(2)


# Publico el mensaje
QOS = 2
retain = False

# Se obtiene y se imprime el mensaje
while(exitFlag == False):
    time.sleep(.5)
    camara: int = random.randint(0, 5)
    topic = "Farmatodo/Sedes/Camaras" + "/{}".format(camara)
    farmacia:int = random.randint(1,3)
    cliente: int = random.randint(1, 4)
    #handleFarmacy(cliente, farmacia, camara)     
    print("\n------------------------------------------")

conn.close()