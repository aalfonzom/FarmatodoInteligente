/*PGDMP
     &                	    w            FarmatodoInteligente    11.5    11.5     X           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            Y           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            Z           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            [           1262    25754    FarmatodoInteligente    DATABASE     t   CREATE DATABASE "FarmatodoInteligente" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
 &   DROP DATABASE "FarmatodoInteligente";
             postgres    false            �            1259    25785    Compra    TABLE     S   CREATE TABLE public."Compra" (
    monto real,
    "id_Compra" integer NOT NULL
);
    DROP TABLE public."Compra";
       public         postgres    false            �            1259    25770    Farmacia    TABLE     $   CREATE TABLE public."Farmacia" (
);
    DROP TABLE public."Farmacia";
       public         postgres    false            �            1259    25755    Persona    TABLE     �   CREATE TABLE public."Persona" (
    sexo text,
    edad integer,
    "id_Persona" integer NOT NULL,
    telefono integer NOT NULL
);
    DROP TABLE public."Persona";
       public         postgres    false            �            1259    25827    Persona_telefono_seq    SEQUENCE     �   CREATE SEQUENCE public."Persona_telefono_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Persona_telefono_seq";
       public       postgres    false    196            \           0    0    Persona_telefono_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public."Persona_telefono_seq" OWNED BY public."Persona".telefono;
            public       postgres    false    201            �            1259    25773    Sede    TABLE     h   CREATE TABLE public."Sede" (
    pasillo integer,
    cajero integer,
    "id_Sede" integer NOT NULL
);
    DROP TABLE public."Sede";
       public         postgres    false            �            1259    25776    Sensor    TABLE     d   CREATE TABLE public."Sensor" (
    hora time without time zone,
    "id_Sensor" integer NOT NULL
);
    DROP TABLE public."Sensor";
       public         postgres    false            �           2604    25829    Persona telefono    DEFAULT     x   ALTER TABLE ONLY public."Persona" ALTER COLUMN telefono SET DEFAULT nextval('public."Persona_telefono_seq"'::regclass);
 A   ALTER TABLE public."Persona" ALTER COLUMN telefono DROP DEFAULT;
       public       postgres    false    201    196            T          0    25785    Compra 
   TABLE DATA               6   COPY public."Compra" (monto, "id_Compra") FROM stdin;
    public       postgres    false    200          Q          0    25770    Farmacia 
   TABLE DATA               $   COPY public."Farmacia"  FROM stdin;
    public       postgres    false    197   -       P          0    25755    Persona 
   TABLE DATA               G   COPY public."Persona" (sexo, edad, "id_Persona", telefono) FROM stdin;
    public       postgres    false    196   J       R          0    25773    Sede 
   TABLE DATA               <   COPY public."Sede" (pasillo, cajero, "id_Sede") FROM stdin;
    public       postgres    false    198   g       S          0    25776    Sensor 
   TABLE DATA               5   COPY public."Sensor" (hora, "id_Sensor") FROM stdin;
    public       postgres    false    199   �       ]           0    0    Persona_telefono_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Persona_telefono_seq"', 1, false);
            public       postgres    false    201            �           2606    25805    Compra Compra_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Compra"
    ADD CONSTRAINT "Compra_pkey" PRIMARY KEY ("id_Compra");
 @   ALTER TABLE ONLY public."Compra" DROP CONSTRAINT "Compra_pkey";
       public         postgres    false    200            �           2606    25807    Persona Persona_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey" PRIMARY KEY ("id_Persona");
 B   ALTER TABLE ONLY public."Persona" DROP CONSTRAINT "Persona_pkey";
       public         postgres    false    196            �           2606    25809    Sede Sede_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Sede"
    ADD CONSTRAINT "Sede_pkey" PRIMARY KEY ("id_Sede");
 <   ALTER TABLE ONLY public."Sede" DROP CONSTRAINT "Sede_pkey";
       public         postgres    false    198            �           2606    25811    Sensor Sensor_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Sensor"
    ADD CONSTRAINT "Sensor_pkey" PRIMARY KEY ("id_Sensor");
 @   ALTER TABLE ONLY public."Sensor" DROP CONSTRAINT "Sensor_pkey";
       public         postgres    false    199            �           2606    25817    Compra id_Persona 
   FK CONSTRAINT     �   ALTER TABLE ONLY public."Compra"
    ADD CONSTRAINT "id_Persona" FOREIGN KEY ("id_Compra") REFERENCES public."Persona"("id_Persona") NOT VALID;
 ?   ALTER TABLE ONLY public."Compra" DROP CONSTRAINT "id_Persona";
       public       postgres    false    200    3021    196            �           2606    25812    Sensor id_Sede 
   FK CONSTRAINT     �   ALTER TABLE ONLY public."Sensor"
    ADD CONSTRAINT "id_Sede" FOREIGN KEY ("id_Sensor") REFERENCES public."Sede"("id_Sede") NOT VALID;
 <   ALTER TABLE ONLY public."Sensor" DROP CONSTRAINT "id_Sede";
       public       postgres    false    3023    198    199            �           2606    25822    Compra id_Sede 
   FK CONSTRAINT     �   ALTER TABLE ONLY public."Compra"
    ADD CONSTRAINT "id_Sede" FOREIGN KEY ("id_Compra") REFERENCES public."Sede"("id_Sede") NOT VALID;
 <   ALTER TABLE ONLY public."Compra" DROP CONSTRAINT "id_Sede";
       public       postgres    false    200    198    3023            T   
   x������ � �      Q   
   x������ � �      P   
   x������ � �      R   
   x������ � �      S   
   x������ � �     