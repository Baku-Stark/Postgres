-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-27 06:49:53.133

-- tables
-- Table: Clients
CREATE TABLE public.Clients (
    ID int  NOT NULL,
    ID_Position int  NOT NULL,
    name varchar(100)  NOT NULL,
    age int  NOT NULL,
    gender char(1)  NOT NULL,
    birth_date date  NOT NULL,
    created_at timestamp  NOT NULL,
    CONSTRAINT Clients_pk PRIMARY KEY (ID)
);

-- Table: Positions
CREATE TABLE public.Positions (
    ID int  NOT NULL,
    name_position varchar(50)  NOT NULL,
    CONSTRAINT Positions_pk PRIMARY KEY (ID)
);

-- foreign keys
-- Reference: Clients_Positions (table: Clients)
ALTER TABLE public.Clients ADD CONSTRAINT Clients_Positions
    FOREIGN KEY (ID_Position)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

