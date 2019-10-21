PGDMP         5             	    w            FarmatodoInteligente    11.5    11.5 !    f           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            g           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            h           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            i           1262    25754    FarmatodoInteligente    DATABASE     t   CREATE DATABASE "FarmatodoInteligente" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
 &   DROP DATABASE "FarmatodoInteligente";
             postgres    false            �            1259    25755    person    TABLE     �   CREATE TABLE public.person (
    gender text,
    age bigint,
    idperson bigint NOT NULL,
    phone bigint NOT NULL,
    namelocation text
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
       public       postgres    false    196            j           0    0    Persona_telefono_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Persona_telefono_seq" OWNED BY public.person.phone;
            public       postgres    false    201            �            1259    25773    location    TABLE     u   CREATE TABLE public.location (
    hall bigint,
    cashier bigint,
    idlocation bigint NOT NULL,
    name text
);
    DROP TABLE public.location;
       public         postgres    false            �            1259    26324    locationperson    TABLE     m   CREATE TABLE public.locationperson (
    idlocation bigint,
    idperson bigint,
    idlp bigint NOT NULL
);
 "   DROP TABLE public.locationperson;
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
       public       postgres    false    201    196            _          0    25773    location 
   TABLE DATA               C   COPY public.location (hall, cashier, idlocation, name) FROM stdin;
    public       postgres    false    198   "       c          0    26324    locationperson 
   TABLE DATA               D   COPY public.locationperson (idlocation, idperson, idlp) FROM stdin;
    public       postgres    false    202   d#       ]          0    25755    person 
   TABLE DATA               L   COPY public.person (gender, age, idperson, phone, namelocation) FROM stdin;
    public       postgres    false    196   �#       ^          0    25770    pharmacy 
   TABLE DATA               "   COPY public.pharmacy  FROM stdin;
    public       postgres    false    197   h+       a          0    25785    purchase 
   TABLE DATA               6   COPY public.purchase (amount, idpurchase) FROM stdin;
    public       postgres    false    200   �+       `          0    25776    sensor 
   TABLE DATA               0   COPY public.sensor (hour, idsensor) FROM stdin;
    public       postgres    false    199   �+       k           0    0    Persona_telefono_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Persona_telefono_seq"', 1, false);
            public       postgres    false    201            �           2606    26372    locationperson idlp 
   CONSTRAINT     S   ALTER TABLE ONLY public.locationperson
    ADD CONSTRAINT idlp PRIMARY KEY (idlp);
 =   ALTER TABLE ONLY public.locationperson DROP CONSTRAINT idlp;
       public         postgres    false    202            �           2606    25854    location location_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (idlocation);
 @   ALTER TABLE ONLY public.location DROP CONSTRAINT location_pkey;
       public         postgres    false    198            �           2606    26370    person namelocation 
   CONSTRAINT     V   ALTER TABLE ONLY public.person
    ADD CONSTRAINT namelocation UNIQUE (namelocation);
 =   ALTER TABLE ONLY public.person DROP CONSTRAINT namelocation;
       public         postgres    false    196            �           2606    25885    person person_pkey 
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
       public         postgres    false    199            �           1259    26332    fki_location    INDEX     M   CREATE INDEX fki_location ON public.locationperson USING btree (idlocation);
     DROP INDEX public.fki_location;
       public         postgres    false    202            �           1259    26338 
   fki_person    INDEX     I   CREATE INDEX fki_person ON public.locationperson USING btree (idperson);
    DROP INDEX public.fki_person;
       public         postgres    false    202            �           2606    26339    sensor idlocation    FK CONSTRAINT     �   ALTER TABLE ONLY public.sensor
    ADD CONSTRAINT idlocation FOREIGN KEY (idsensor) REFERENCES public.location(idlocation) NOT VALID;
 ;   ALTER TABLE ONLY public.sensor DROP CONSTRAINT idlocation;
       public       postgres    false    199    3030    198            �           2606    26344    purchase idlocation    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT idlocation FOREIGN KEY (idpurchase) REFERENCES public.location(idlocation) NOT VALID;
 =   ALTER TABLE ONLY public.purchase DROP CONSTRAINT idlocation;
       public       postgres    false    3030    198    200            �           2606    25908    purchase idperson    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT idperson FOREIGN KEY (idpurchase) REFERENCES public.person(idperson) NOT VALID;
 ;   ALTER TABLE ONLY public.purchase DROP CONSTRAINT idperson;
       public       postgres    false    3028    196    200            �           2606    26373    locationperson location    FK CONSTRAINT     �   ALTER TABLE ONLY public.locationperson
    ADD CONSTRAINT location FOREIGN KEY (idlocation) REFERENCES public.location(idlocation) NOT VALID;
 A   ALTER TABLE ONLY public.locationperson DROP CONSTRAINT location;
       public       postgres    false    198    3030    202            �           2606    26333    locationperson person    FK CONSTRAINT     �   ALTER TABLE ONLY public.locationperson
    ADD CONSTRAINT person FOREIGN KEY (idperson) REFERENCES public.person(idperson) NOT VALID;
 ?   ALTER TABLE ONLY public.locationperson DROP CONSTRAINT person;
       public       postgres    false    196    202    3028            _   P  x�=R�q�0{c��H��D*���D�Q�AZ��mk����-d��yێ-�u���:jP""��V�|���"�Zנ��`�GX��;�� �NUG6LV�p>�!%2���o�DCMszZ�Q�Ġͪ��)KԏǨ@�qc����#�`}e]�>;�m��H�:>����v�RA�[��J�̦Q�'���5#0�1B���9.�2A7��./8��wa01�]�E�P�:+=纅��}�z���[V=l�л�����"�[9��==�ŝ���7����^`�o"��3�=�#��W��Y���O�"lxM��7tk���#������|� �4��      c      x������ � �      ]   �  x�E�[rd)D��3�����of��u��*�nw�aS�����g�g�ݱ�e����#����ϟg���|���Lx�-�������ܹד�:gL��ﾙO�����{�Go��>.��ܷW�XkU�9ӟYڼ�l͑��]��(+"ѹ�|ڜ������3���]3��}��U�zp���I�`۞͉Q1b�>�ٳ�׊g[�j����X�NUe��eDz���Y���,�m��93�ݳ���h��QӿkY�9��岜k��3{?|��mnّާ���d��j�=:}�(�ǘNFO���Jд1|�o�d�{�j5�)ꌴM����>�[I�ҭ1	h��h�9��n�]"�M[I���1������vY�ࢢ��=��P^&���yR�YN���ȱ���(�q*���̨63O��7ݦ5�N#��/��ds�~�՛���2�T� �@�v�>�kPd�mЧ=+�7\9= �P���0MH��RZ=ؗ~�}���i�b&����d�)��I���Y���(X"�Ua���h6s]��ֲ��s��9	1l��e�jhM�����ֲ�j��&1V�d�Ɂnr�.�]D�&�{	_��2��}�
����҄���?|��]"IŁ,'rv�	�I<�/�=)�J9l��rCrz+qq� ���B����.eǎ�< ���Lڶ^E$���z���s��DƑ�z��}z ���B� C;��/��L�	 ,7U��OR^`��Rgk�v�E\h�$ܖ�`�(�*rH-�C�g��EM�*����� +�K��!"�������O��"�i������t���'@z���!f��|�^G�)jD2;��:th�0Z��4 ��m9�_��6S���� 0�7/�ʪ_� Xt&����|b���f��>���׻��H
��ҧ�<=��Krm@Z>���pB)BahA��x�@b.Kl|d�Dxh9 k��t�K��n ��w6��5�Q�a�[C�*�@�&��
Ch���P&a_�G��4�KӜ3���l�f��!"h���+4�!�1�'0�M��Lz;#�h��);��+gP�B^h���yj�k �?ҧ	QQ���05�6As~N	�N�"��q)�~5!��*D�ɽ�UT�G}�2E�oc%���%�w��p���6�&�{X�N xk���4��.p/���p���]�]	$LSf\ʲ�J��aF�ݙ�>�����Z��I��H��4%����f����ҳ��x2H��4�3i߸�N)��4�.Q���� )�n�/��l��nR�85ߗy�e�#"bv]�o�{6r����%�.�B�AOp)��&���(i}&��A��������k�r����2�?�"��iG���\�@�o���:��y$nCR�׺��9�����q����Y�@��!}|���^D��@�&�58u���͔t'T��Z���h�j��ҨbAo��N
�Hw�i&�^��s<�(�}��D9k�}�Q.�Si$_������.���C����h���.HH4�:�֬Ĵ��i�:��c�����0競�؈��,�\\_���.��`���t���q�J�Z�PnÌ0��Ǖ0h���x�)�G� Ǽs�P�-�� �-�=��(:����)h%|�q ]�� %`��E�|2D���H�4�=蜂3:�QE=�����@l����}�Q���J�9Zs�2e�M���L��Ό��C/�h�<>*�DЎԠǖ���c��L�!�GZ�G�M���.ju��q��En
�S���q^.D�cZ4�>=p�E��j|�t!��&�[20�+�C&/��|m�b���q��;u�A=��J�B�k)?�\�N���Q����0ი��f����Ř4w~1^}c��8�=/��_�	�
C����^ j̱�C"��q��q�<M#axߔ��������      ^      x������ � �      a      x������ � �      `      x������ � �     