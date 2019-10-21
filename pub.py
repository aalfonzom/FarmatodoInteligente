import paho.mqtt.client as mqtt
import time
import random
import datetime
import psycopg2 as psy

def createMacAddress():    
    mac_Address  = random.randrange(100000000000,999999999999)
    return mac_Address

def createGender():
    list  = [1,0]
    gender = random.choice(list)
    if(gender == 1):
        gender = 'M'
    else :
        gender = 'F'
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

def CreateSede(id):
    try:
        conn = psy.connect(
            user="postgres",
            password="admin",
            host='localhost',
            port="5432",
            database="FarmatodoInteligente"
        )
        cursor = conn.cursor()
        query = "SELECT idlocation  FROM location WHERE idperson = {}".format(id)
        cursor.execute(query)
        data = cursor.fetchone()
        pharmacy = int(data[0])
        return pharmacy

    except (Exception, psy.Error) as error:
        print("Error", error)

    finally:
        if(conn):
            cursor.close()
            conn.close()

def getClients(id, gender, age, macAddress):
    try:  # creo la conexion
        conn = psy.connect(
            user="postgres",
            password="admin",
            host='localhost',
            port="5432",
            database="FarmatodoInteligente"
        )
        cursor = conn.cursor()
        # Realizo el query
        query = "SELECT idperson FROM person WHERE idperson = {}".format(id)
        cursor.execute(query)
        row = cursor.fetchone()

        if(row is not None):
            print("ya existe")

        else:  # Logica de si no existe
            insert = "INSERT into person (idperson, gender, age, phone) VALUES ({},'{}',{},{})".format(
                id, gender, age, macAddress)
            cursor.execute(insert, (id, gender, age, macAddress))
            conn.commit()

    except (Exception, psy.Error) as error:
        print("Error", error)

    finally:
        if(conn):
            cursor.close()
            conn.close()

def main(cliente, camara, farmacia):
    if(camara == 0):  # el cliente pasa por la puerta principal
        gender = createGender()
        age = createAge()
        id = createId()
        macAddress = createMacAddress()
        getClients(cliente, gender, age, macAddress)

        if(result):
            salidaFarmacia = CreateSede(cliente)
            payload = "El cliente {} está saliendo de la farmacia {}".format(cliente, salidaFarmacia)
            client.publish(topic, payload, QOS, retain)
            updateClient(cliente, result, farmacia)
            time.sleep(4)

        else:
            payload = "El cliente {} está entrando a la farmacia {}".format(cliente, farmacia)
            client.publish(topic, payload, QOS, retain)
            updateClient(cliente, result, farmacia)
            time.sleep(4)

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


#Funcion que se ejecuta cuando ocurre la coneccion
def on_connect(client,userdata,flags,rc):   
    global exitFlag
    if(rc == 0): #si la coneccion es exitosa
        print("\n------------------------------------------")   
        print("El publicador se ha conectado")
        print("Se ha conectado al cliente. Codigo:"+str(rc))
        exitFlag = False

    elif(rc == 5): #Si hay un error en la coneccion
        print("\n------------------------------------------")   
        print("Error en la coneccion. Codigo:"+str(rc))
        client.disconnect()
        exitFlag = True


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
retain = True

# Se obtiene y se imprime el mensaje
while(exitFlag == False):
    time.sleep(3)
    camara: int = random.randint(0, 5)
    topic = "Farmatodo/Camara" + "/{}".format(camara)
    farmacia:int = random.randint(1,5)
    cliente: int = random.randint(1, 1000000)
    payload = "El Cliente {} ha entrado a la Farmacia {}".format(cliente, farmacia)
    client.publish(topic, payload, QOS, retain)
    main(cliente, camara, farmacia)     
    print("\n------------------------------------------")
  