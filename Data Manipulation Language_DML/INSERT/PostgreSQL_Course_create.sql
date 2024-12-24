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

INSERT INTO public.clients (ID, name, age, gender, birth_date, created_at)
VALUES 
(1, 'Alice', 30, 'F', '1994-05-15', '2024-12-22 10:00:00'),
(2, 'Bob', 25, 'M', '1998-03-22', '2024-12-22 10:05:00'),
(3, 'Charlie', 40, 'M', '1984-11-10', '2024-12-22 10:10:00'),
(4, 'Diana', 35, 'F', '1988-02-01', '2024-12-22 10:15:00'),
(5, 'Eve', 28, 'F', '1996-09-18', '2024-12-22 10:20:00');

select * from clients;

-- End of file.

