-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-24 01:52:10.855
-- tables
-- Table: Clients
CREATE TABLE public.Clients (
   ID int  NOT NULL,
   name varchar(100)  NOT NULL,
   age int  NOT NULL,
   gender char(1)  NOT NULL,
   birth_date date  NOT NULL,
   created_at timestamp  NOT NULL,
   CONSTRAINT Clients_pk PRIMARY KEY (ID)
);

select * from clients;

-- End of file.

