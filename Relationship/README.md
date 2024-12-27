# 🐘 | Database Relationship


<div align="center">

<img height="150" width="250" src="https://th.bing.com/th/id/OIP.qSUJggK1vr-c9K2sSlxs4AHaCT?rs=1&pid=ImgDetMain" />

`🐘 : relationship`

</div>

---- 

## 🐘 | Creating Tables

```sql
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
```

### 0:*

```sql
-- foreign keys
-- Reference: Clients_Positions (table: Clients)
ALTER TABLE public.Clients ADD CONSTRAINT Clients_Positions
    FOREIGN KEY (Positions_ID)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;
```

### 0:1

```sql
-- foreign keys
-- Reference: Clients_Positions (table: Clients)
ALTER TABLE public.Clients ADD CONSTRAINT Clients_Positions
    FOREIGN KEY (ID_Position)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;
```

### 1:*

```sql
-- foreign keys
-- Reference: Clients_Positions (table: Clients)
ALTER TABLE public.Clients ADD CONSTRAINT Clients_Positions
    FOREIGN KEY (ID_Position)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;
```

### 1:1

```sql
-- foreign keys
-- Reference: Clients_Positions (table: Clients)
ALTER TABLE public.Clients ADD CONSTRAINT Clients_Positions
    FOREIGN KEY (ID_Position)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;
```

----

# 🐘 | Como Identificar as relações pelo SQL

Para determinar o tipo de relacionamento entre as tabelas apenas analisando o SQL, você precisa observar os seguintes aspectos:

---

### **1. Analisando a Foreign Key**
No SQL fornecido:

```sql
ALTER TABLE public.Clients ADD CONSTRAINT Clients_Positions
    FOREIGN KEY (Positions_ID)
    REFERENCES public.Positions (ID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;
```

Isso mostra que:
- **`Clients`** tem uma coluna `Positions_ID` que faz referência à chave primária da tabela **`Positions`** (`ID`).
- Isso implica um relacionamento entre as tabelas, do tipo **`Positions (1) → Clients (0..*)`**.

---

### **2. Determinando o tipo de relacionamento**
- A tabela `Clients` pode ter **0 ou mais registros** associados a um único registro em `Positions`, porque:
  - A foreign key `Positions_ID` **não é única** na tabela `Clients` (permitindo múltiplos registros com o mesmo cargo).
  - A chave estrangeira é **NOT NULL**, indicando que todo cliente precisa ter um cargo (não pode haver clientes sem posição associada).

Portanto, o relacionamento é **1:N** (ou **0..*:1** em termos UML):
- Uma posição em `Positions` pode estar associada a vários clientes em `Clients`.
- Um cliente em `Clients` deve obrigatoriamente estar associado a uma posição em `Positions`.

---

### **3. Como identificar o cardinalidade pelo SQL**
Veja como determinar o tipo de relacionamento observando o SQL:

| Aspecto                   | O que analisar                                                                                     |
|---------------------------|----------------------------------------------------------------------------------------------------|
| **Primary Key**           | A tabela referenciada (`Positions`) tem uma chave primária (`ID`), indicando **1** no lado referenciado. |
| **Foreign Key**           | A tabela com a foreign key (`Clients`) permite múltiplos valores associados à mesma referência, indicando **0..*** ou **N**. |
| **Restrição NOT NULL**    | A foreign key `Positions_ID` em `Clients` é **NOT NULL**, então cada cliente deve ter uma posição associada. |

----

## 🐘 | Inserts

```sql
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
```




