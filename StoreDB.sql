Enter password: ***********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.36 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| centre_formation   |
| information_schema |
| isgi               |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| test1              |
| world              |
+--------------------+
9 rows in set (0.03 sec)

mysql> create database storDB;
Query OK, 1 row affected (0.03 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| centre_formation   |
| information_schema |
| isgi               |
| mysql              |
| performance_schema |
| sakila             |
| stordb             |
| sys                |
| test1              |
| world              |
+--------------------+
10 rows in set (0.01 sec)

mysql> use stordb;
Database changed
mysql> create table clients(
    -> id_client int primary key,
    -> nom varchar(10),
    -> prenom varchar(10),
    -> email varchar(40),
    -> adresse varchar(50),
    -> telephone int);
Query OK, 0 rows affected (0.13 sec)

mysql> show tables;
+------------------+
| Tables_in_stordb |
+------------------+
| clients          |
+------------------+
1 row in set (0.02 sec)

mysql> create table  produits(
    -> id_produit ind primary key,
    -> nom varchar(10),
    -> description varchar(100),
    -> prix float,
    -> stock int);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'ind primary key,
nom varchar(10),
description varchar(100),
prix float,
stock in' at line 2
mysql> create table produits(
    -> id_produit int primary key,
    -> nom varchar(10),
    -> description varchar(100),
    -> prix float,
    -> stock int);
Query OK, 0 rows affected (0.07 sec)

mysql> show tables;
+------------------+
| Tables_in_stordb |
+------------------+
| clients          |
| produits         |
+------------------+
2 rows in set (0.00 sec)

mysql> create table commandes(
    -> id_commande int primary key,
    -> foreign key (id_client)references clients(id_client),
    -> totel float);
ERROR 1072 (42000): Key column 'id_client' doesn't exist in table
mysql> create table commandes(
    -> id_commande int primary key,
    -> id_client int,
    -> total float);
Query OK, 0 rows affected (0.04 sec)

mysql> desc commandes;
+-------------+-------+------+-----+---------+-------+
| Field       | Type  | Null | Key | Default | Extra |
+-------------+-------+------+-----+---------+-------+
| id_commande | int   | NO   | PRI | NULL    |       |
| id_client   | int   | YES  |     | NULL    |       |
| total       | float | YES  |     | NULL    |       |
+-------------+-------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> alter table commandes
    -> add foreign key (id_client) references clients (id_client);
Query OK, 0 rows affected (0.12 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc commandes;
+-------------+-------+------+-----+---------+-------+
| Field       | Type  | Null | Key | Default | Extra |
+-------------+-------+------+-----+---------+-------+
| id_commande | int   | NO   | PRI | NULL    |       |
| id_client   | int   | YES  | MUL | NULL    |       |
| total       | float | YES  |     | NULL    |       |
+-------------+-------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> altercommandes
    -> add column date_commande date;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'altercommandes
add column date_commande date' at line 1
mysql> alter commandes
    -> add column date_commande date;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'commandes
add column date_commande date' at line 1
mysql> alter table commandes
    -> add column date_commande date;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table commandes
    -> modify date_commande date default (current_date());
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc commandes;
+---------------+-------+------+-----+-----------+-------------------+
| Field         | Type  | Null | Key | Default   | Extra             |
+---------------+-------+------+-----+-----------+-------------------+
| id_commande   | int   | NO   | PRI | NULL      |                   |
| id_client     | int   | YES  | MUL | NULL      |                   |
| total         | float | YES  |     | NULL      |                   |
| date_commande | date  | YES  |     | curdate() | DEFAULT_GENERATED |
+---------------+-------+------+-----+-----------+-------------------+
4 rows in set (0.00 sec)

mysql> alter table commande
    -> add statut varchar(10) check (statut in(en cours,livree,annulee));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'cours,livree,annulee))' at line 2
mysql> alter table commandes
    -> add statut varchar(10) check (statut in(en cours,livree,annulee));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'cours,livree,annulee))' at line 2
mysql> alter table commande
    -> add statut varchar(10) check (statut in('en cours','livree','annulee'));
ERROR 1146 (42S02): Table 'stordb.commande' doesn't exist
mysql> alter table commandes
    -> add statut varchar(10) check (statut in('en cours','livree','annulee'));
Query OK, 0 rows affected (0.14 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table commandes
    -> modify statut varchar(10) default 'en cours';
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc clients;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| id_client | int         | NO   | PRI | NULL    |       |
| nom       | varchar(10) | YES  |     | NULL    |       |
| prenom    | varchar(10) | YES  |     | NULL    |       |
| email     | varchar(40) | YES  |     | NULL    |       |
| adresse   | varchar(50) | YES  |     | NULL    |       |
| telephone | int         | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
6 rows in set (0.01 sec)

mysql> desc produits;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| id_produit  | int          | NO   | PRI | NULL    |       |
| nom         | varchar(10)  | YES  |     | NULL    |       |
| description | varchar(100) | YES  |     | NULL    |       |
| prix        | float        | YES  |     | NULL    |       |
| stock       | int          | YES  |     | NULL    |       |
+-------------+--------------+------+-----+---------+-------+
5 rows in set (0.00 sec)

mysql> desc commandes;
+---------------+-------------+------+-----+-----------+-------------------+
| Field         | Type        | Null | Key | Default   | Extra             |
+---------------+-------------+------+-----+-----------+-------------------+
| id_commande   | int         | NO   | PRI | NULL      |                   |
| id_client     | int         | YES  | MUL | NULL      |                   |
| total         | float       | YES  |     | NULL      |                   |
| date_commande | date        | YES  |     | curdate() | DEFAULT_GENERATED |
| statut        | varchar(10) | YES  |     | en cours  |                   |
+---------------+-------------+------+-----+-----------+-------------------+
5 rows in set (0.00 sec)

mysql> show tables;
+------------------+
| Tables_in_stordb |
+------------------+
| clients          |
| commandes        |
| produits         |
+------------------+
3 rows in set (0.00 sec)

mysql>