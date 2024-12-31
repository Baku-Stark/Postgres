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

# 🐘 | JOINs

Abaixo estão exemplos de todos os principais tipos de **JOINS** no PostgreSQL aplicados às tabelas `Clients` e `Positions`. Além disso, explico para que serve cada tipo de JOIN.

### **1. INNER JOIN**
**Serve para**: Combinar registros onde há correspondência em ambas as tabelas.

```sql
SELECT c.ID AS client_id, c.name AS client_name, p.name_position AS position
FROM public.Clients c
INNER JOIN public.Positions p
ON c.Positions_ID = p.ID;
```

**Resultado**: Retorna apenas os clientes que possuem uma posição válida (ou seja, que estão corretamente relacionados na tabela `Positions`).

### **2. LEFT JOIN (ou LEFT OUTER JOIN)**
**Serve para**: Retorna todos os registros da tabela à esquerda (neste caso, `Clients`), mesmo que não haja correspondência na tabela à direita (`Positions`). Os valores sem correspondência na tabela à direita aparecem como `NULL`.

```sql
SELECT c.ID AS client_id, c.name AS client_name, p.name_position AS position
FROM public.Clients c
LEFT JOIN public.Positions p
ON c.Positions_ID = p.ID;
```

**Resultado**: Retorna todos os clientes, incluindo aqueles que não têm um cargo definido (ou seja, sem correspondência em `Positions`).

### **3. RIGHT JOIN (ou RIGHT OUTER JOIN)**
**Serve para**: Retorna todos os registros da tabela à direita (`Positions`), mesmo que não haja correspondência na tabela à esquerda (`Clients`). Os valores sem correspondência na tabela à esquerda aparecem como `NULL`.

```sql
SELECT c.ID AS client_id, c.name AS client_name, p.name_position AS position
FROM public.Clients c
RIGHT JOIN public.Positions p
ON c.Positions_ID = p.ID;
```

**Resultado**: Retorna todas as posições, mesmo que não haja clientes associados a elas.

### **4. FULL JOIN (ou FULL OUTER JOIN)**
**Serve para**: Combina registros de ambas as tabelas, retornando todos os registros, mesmo quando não há correspondência. Valores sem correspondência aparecem como `NULL`.

```sql
SELECT c.ID AS client_id, c.name AS client_name, p.name_position AS position
FROM public.Clients c
FULL JOIN public.Positions p
ON c.Positions_ID = p.ID;
```

**Resultado**: Retorna todos os clientes e todos os cargos, incluindo aqueles que não possuem correspondência entre si.

### **5. CROSS JOIN**
**Serve para**: Retorna o produto cartesiano das duas tabelas, combinando cada linha da tabela `Clients` com cada linha da tabela `Positions`.

```sql
SELECT c.ID AS client_id, c.name AS client_name, p.name_position AS position
FROM public.Clients c
CROSS JOIN public.Positions p;
```

**Resultado**: Cada cliente é combinado com cada posição, independentemente de qualquer relação.

### **6. SELF JOIN**
**Serve para**: É um join de uma tabela com ela mesma. Útil quando você precisa comparar registros da mesma tabela.

#### Exemplo: Encontrar clientes com a mesma idade
```sql
SELECT c1.ID AS client_id_1, c1.name AS client_name_1, 
       c2.ID AS client_id_2, c2.name AS client_name_2
FROM public.Clients c1
INNER JOIN public.Clients c2
ON c1.age = c2.age AND c1.ID != c2.ID;
```

**Resultado**: Retorna pares de clientes que possuem a mesma idade.

### **Resumo dos Tipos de JOIN**

| **Tipo de JOIN** | **Descrição**                                                                                                                                     |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| **INNER JOIN**   | Retorna apenas os registros com correspondência em ambas as tabelas.                                                                             |
| **LEFT JOIN**    | Retorna todos os registros da tabela à esquerda, mesmo sem correspondência na tabela à direita.                                                  |
| **RIGHT JOIN**   | Retorna todos os registros da tabela à direita, mesmo sem correspondência na tabela à esquerda.                                                  |
| **FULL JOIN**    | Retorna todos os registros de ambas as tabelas, mesmo sem correspondência (valores não correspondentes aparecem como `NULL`).                    |
| **CROSS JOIN**   | Retorna o produto cartesiano de ambas as tabelas (combina cada linha de uma tabela com cada linha da outra).                                      |
| **SELF JOIN**    | Junta uma tabela com ela mesma, útil para comparar ou relacionar registros na mesma tabela.                                                      |

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




