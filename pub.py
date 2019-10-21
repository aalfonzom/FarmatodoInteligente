import paho.mqtt.client as mqtt
import time
import random
import datetime
import psycopg2 as psy

def createIdlp():
    idpl = random.randint(1,100)
    return idpl

def createMacAddress():    
    macAddress  = random.randrange(100000000000,999999999999)
    return macAddress

#se genera una lista para decidir el randow entre el genero
def createGender():
    list  = [1,0]
    gender = random.choice(list)
    if(gender == 1):
        gender = 'M'
    else :
        gender = 'F'
    return gender

#caja registradora
def createCashier():
    cashier = random.randint(1,5)
    return cashier

#pasillos
def createHall():
    hall = random.randint(1,5)
    return hall

#suponiendo que existen 20 sedes diferentes, se genera un random de la Sede
def createIdlocation():
    idlocation = random.randint(1,20)
    return idlocation

#definiendo el rango de edad entre 1 y 100 anos 
def createAge():
    age = random.randint(1,100)
    return age



def createId():
    id = random.randint(1, 1000000)
    return id

#metodo para saber si una persona tiene o no telf inteligente
def hasPhone():
    phone = random.randint(0,5)
    if(phone != 3):
        macAddres = createMacAddress()
        return macAddres

    else:
        return '0'

def getClients(id, gender, age, macAddress):
    try:  
        conn = psy.connect(
            user="postgres",
            password="miravila1", #establenciendo la conexion con la bdd
            host='localhost',
            port="5432",
            database="FarmatodoInteligente"
        )
        cursor = conn.cursor()
        
        query = "SELECT idperson FROM person WHERE idperson = {}".format(id)
        cursor.execute(query)
        row = cursor.fetchone()

        if(row is not None):
            print("ya existe")

        else:  
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


def getLocationPerson(idlocation, idperson, idlp):
    try:
        conn = psy.connect(
            user="postgres",
            password="miravila1", #estableciendo conexion  con la bdd
            host='localhost',
            port="5432",
            database="FarmatodoInteligente"
        )
        
        cursor = conn.cursor()
        #query1 = "SELECT idperson FROM person WHERE idperson = {}".format(id)
        #query2 = "SELECT idlocation FROM location WHERE idlocation = {}".format(idlocation)
        query = "INSERT into locationperson (idlocation, idperson, idlp) VALUES ({},{},{})".format(
            idlocation, idperson, idlp)
        cursor.execute(query)
        conn.commit()
    except (Exception, psy.Error) as error:
        print("Error", error)

    finally:
        if(conn):
            cursor.close()
            conn.close()

        


#Metodo para obtener locations/sedes
def getLocations(hall,cashier, idlocation):
    try: #creo conexion con la BDD
        conn = psy.connect(
            user="postgres",
            password="miravila1",
            host='localhost',
            port="5432",
            database="FarmatodoInteligente"
        )
        cursor = conn.cursor()
        
        query = "INSERT into location (hall, cashier, idlocation) VALUES ({},{},{})".format(
            hall, cashier, idlocation)
        cursor.execute(query)
        conn.commit()
           
    except (Exception, psy.Error) as error:
        print("Error", error)

    finally:
        if(conn):
           cursor.close()
           conn.close()


def main(cliente, camara):
    #Sedes Existentes
    hall = createHall()
    cashier = createCashier()
    idlp = createIdlp()
    idlocation = createIdlocation()
    gender = createGender()
    age = createAge()
    id = createId()
    macAddress = createMacAddress()
    getClients(cliente, gender, age, macAddress)
    getLocations(hall, cashier, idlocation)
    getLocationPerson(idlocation,id,idlp)


client = mqtt.Client("Cliente") #variables
broker = "localhost"
exitFlag = True
date = datetime.datetime.now()


# publicacion de la data 
def on_publish(client, userdata, mid):
    print("\n------------------------------------------")
    print("Hora del mensaje : "+str(date))
    print("Mensaje Publicado: "+str(mid))
    

def on_connect(client,userdata,flags,rc):   
    global exitFlag
    if(rc == 0): 
        print("\n------------------------------------------")   
        print("El publicador se ha conectado")
        print("Se ha conectado al cliente. Codigo:"+str(rc))
        exitFlag = False

    elif(rc == 5):
        print("\n------------------------------------------")   
        print("Error en la conexion. Codigo:"+str(rc))
        client.disconnect()
        exitFlag = True


# desconexion de la data
def on_disconnect(pvtClient, userdata, rc):
    print("Razon de la desconexion: " + str(rc))
    client.disconnect()


#procedimientos generales del publicador 
client.on_publish = on_publish
client.on_connect = on_connect
client.on_disconnect = on_disconnect


client.connect(broker)

client.loop_start()
time.sleep(2)




QOS = 2 #quality of service 2
retain = True

#manera temporal de imprimir los comentarios 
while(exitFlag == False):
    time.sleep(3)
    camara: int = random.randint(0, 5)
    camara = 0
    topic = "Farmatodo/Camara" + "/{}".format(camara)
    farmacia:int = random.randint(1,3)
    cliente: int = random.randint(1, 1000000)
    payload = "El Cliente {} ha entrado a la Farmacia {}".format(cliente, farmacia)
    client.publish(topic, payload, QOS, retain)
    main(cliente, camara)     
    print("\n------------------------------------------")

