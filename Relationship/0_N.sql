-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-27 05:44:11.515

-- tables
-- Table: Clients
CREATE TABLE public.Clients (
    ID int  NOT NULL,
    name varchar(100)  NOT NULL,
    age int  NOT NULL,
    gender char(1)  NOT NULL,
    birth_date date  NOT NULL,
    created_at timestamp  NOT NULL,
    Positions_ID int  NOT NULL,
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
    FOREIGN KEY (Positions_ID)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

INSERT INTO public.Positions (ID, name_position)
VALUES 
(1, 'Manager'),
(2, 'Developer'),
(3, 'Designer'),
(4, 'Analyst'),
(5, 'Intern');

INSERT INTO public.Clients (ID, name, age, gender, birth_date, created_at, Positions_ID)
VALUES 
(1, 'Alice Johnson', 30, 'F', '1994-05-15', '2024-12-22 10:00:00', 1),
(2, 'Bob Smith', 25, 'M', '1998-03-22', '2024-12-22 10:05:00', 2),
(3, 'Charlie Brown', 40, 'M', '1984-11-10', '2024-12-22 10:10:00', 3),
(4, 'Diana White', 35, 'F', '1988-02-01', '2024-12-22 10:15:00', 4),
(5, 'Eve Black', 28, 'F', '1996-09-18', '2024-12-22 10:20:00', 5);


