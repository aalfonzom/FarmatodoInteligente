PGDMP     *                	    w            FarmatodoInteligente    11.5    11.5     X           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            Y           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            Z           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            [           1262    25754    FarmatodoInteligente    DATABASE     t   CREATE DATABASE "FarmatodoInteligente" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
 &   DROP DATABASE "FarmatodoInteligente";
             postgres    false            �            1259    25755    person    TABLE     y   CREATE TABLE public.person (
    gender text,
    age bigint,
    idperson bigint NOT NULL,
    phone bigint NOT NULL
);
    DROP TABLE public.person;
       public         postgres    false            �            1259    25827    Persona_telefono_seq    SEQUENCE     �   CREATE SEQUENCE public."Persona_telefono_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Persona_telefono_seq";
       public       postgres    false    196            \           0    0    Persona_telefono_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Persona_telefono_seq" OWNED BY public.person.phone;
            public       postgres    false    201            �            1259    25773    location    TABLE     f   CREATE TABLE public.location (
    hall bigint,
    cashier bigint,
    idlocation bigint NOT NULL
);
    DROP TABLE public.location;
       public         postgres    false            �            1259    25770    pharmacy    TABLE     "   CREATE TABLE public.pharmacy (
);
    DROP TABLE public.pharmacy;
       public         postgres    false            �            1259    25785    purchase    TABLE     R   CREATE TABLE public.purchase (
    amount real,
    idpurchase bigint NOT NULL
);
    DROP TABLE public.purchase;
       public         postgres    false            �            1259    25776    sensor    TABLE     ^   CREATE TABLE public.sensor (
    hour time without time zone,
    idsensor bigint NOT NULL
);
    DROP TABLE public.sensor;
       public         postgres    false            �           2604    25898    person phone    DEFAULT     r   ALTER TABLE ONLY public.person ALTER COLUMN phone SET DEFAULT nextval('public."Persona_telefono_seq"'::regclass);
 ;   ALTER TABLE public.person ALTER COLUMN phone DROP DEFAULT;
       public       postgres    false    201    196            R          0    25773    location 
   TABLE DATA               =   COPY public.location (hall, cashier, idlocation) FROM stdin;
    public       postgres    false    198   �       P          0    25755    person 
   TABLE DATA               >   COPY public.person (gender, age, idperson, phone) FROM stdin;
    public       postgres    false    196   �       Q          0    25770    pharmacy 
   TABLE DATA               "   COPY public.pharmacy  FROM stdin;
    public       postgres    false    197          T          0    25785    purchase 
   TABLE DATA               6   COPY public.purchase (amount, idpurchase) FROM stdin;
    public       postgres    false    200   !       S          0    25776    sensor 
   TABLE DATA               0   COPY public.sensor (hour, idsensor) FROM stdin;
    public       postgres    false    199   >       ]           0    0    Persona_telefono_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Persona_telefono_seq"', 1, false);
            public       postgres    false    201            �           2606    25854    location location_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (idlocation);
 @   ALTER TABLE ONLY public.location DROP CONSTRAINT location_pkey;
       public         postgres    false    198            �           2606    25885    person person_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (idperson);
 <   ALTER TABLE ONLY public.person DROP CONSTRAINT person_pkey;
       public         postgres    false    196            �           2606    25907    purchase purchase_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (idpurchase);
 @   ALTER TABLE ONLY public.purchase DROP CONSTRAINT purchase_pkey;
       public         postgres    false    200            �           2606    25923    sensor sensor_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.sensor
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (idsensor);
 <   ALTER TABLE ONLY public.sensor DROP CONSTRAINT sensor_pkey;
       public         postgres    false    199            �           2606    25913    purchase idlocation    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT idlocation FOREIGN KEY (idpurchase) REFERENCES public.location(idlocation) NOT VALID;
 =   ALTER TABLE ONLY public.purchase DROP CONSTRAINT idlocation;
       public       postgres    false    3023    198    200            �           2606    25924    sensor idlocation    FK CONSTRAINT     �   ALTER TABLE ONLY public.sensor
    ADD CONSTRAINT idlocation FOREIGN KEY (idsensor) REFERENCES public.location(idlocation) NOT VALID;
 ;   ALTER TABLE ONLY public.sensor DROP CONSTRAINT idlocation;
       public       postgres    false    3023    198    199            �           2606    25908    purchase idperson    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT idperson FOREIGN KEY (idpurchase) REFERENCES public.person(idperson) NOT VALID;
 ;   ALTER TABLE ONLY public.purchase DROP CONSTRAINT idperson;
       public       postgres    false    196    200    3021            R      x������ � �      P      x������ � �      Q      x������ � �      T      x������ � �      S      x������ � �     