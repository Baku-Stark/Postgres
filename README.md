# Postgres SQL

<div align="center">

<img height="50" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/postgresql/postgresql-original-wordmark.svg" />

</div>

# 🐘 | 1° Método de instalação
### **1. Atualize os pacotes do sistema**
Abra o terminal e atualize o índice dos pacotes do sistema:

```bash
sudo apt update
sudo apt upgrade -y
```

### **2. Instale o PostgreSQL**
Use o comando abaixo para instalar o PostgreSQL e suas ferramentas:

```bash
sudo apt install postgresql postgresql-contrib -y
```

### **3. Verifique o serviço do PostgreSQL**
Depois de instalar, verifique se o serviço está ativo:

```bash
sudo systemctl status postgresql
```

Se não estiver ativo, inicie o serviço com:

```bash
sudo systemctl start postgresql
```

### **4. Acesse o PostgreSQL**
Por padrão, o PostgreSQL cria um usuário chamado `postgres`. Para acessar o banco de dados como esse usuário, use:

```bash
sudo -i -u postgres
psql
```

No prompt do `psql`, você verá algo como:

```
postgres=#
```

### **5. Configure uma senha para o usuário `postgres`**
Dentro do console do PostgreSQL, execute:

```sql
\password postgres
```

Digite e confirme a nova senha.

### **6. Saia do console do PostgreSQL**
Para sair, digite:

```sql
\q
```

### **7. Configure o acesso remoto (opcional)**
Se você quiser acessar o PostgreSQL remotamente:

1. Edite o arquivo de configuração:

   ```bash
   sudo nano /etc/postgresql/<versão>/main/pg_hba.conf
   ```

2. Altere o método de autenticação para `md5` em vez de `peer` para conexões locais ou externas.

3. Edite o arquivo `postgresql.conf` para permitir conexões externas:

   ```bash
   sudo nano /etc/postgresql/<versão>/main/postgresql.conf
   ```

   Encontre e altere a linha:

   ```plaintext
   listen_addresses = 'localhost'
   ```

   Para:

   ```plaintext
   listen_addresses = '*'
   ```

4. Reinicie o PostgreSQL:

   ```bash
   sudo systemctl restart postgresql
   ```

---

### **8. Teste a instalação**
Teste a conexão localmente usando o usuário `postgres`:

```bash
psql -U postgres
```

---

# 🐘 | 2° Método de instalação

Claro! Aqui está um guia passo a passo para instalar o PostgreSQL no Ubuntu:

### **1. Atualizar o sistema**
Abra o terminal e atualize os repositórios de pacotes:

```bash
sudo apt update
sudo apt upgrade -y
```

### **2. Instalar o PostgreSQL**
Use o seguinte comando para instalar o PostgreSQL e sua interface de linha de comando (psql):

```bash
sudo apt install postgresql postgresql-contrib -y
```

### **3. Verificar o status do serviço**
Após a instalação, o PostgreSQL geralmente inicia automaticamente. Verifique se o serviço está ativo:

```bash
sudo systemctl status postgresql
```

Você deve ver algo como **"active (running)"**. Pressione `q` para sair.

Se não estiver ativo, inicie o serviço com:

```bash
sudo systemctl start postgresql
```

### **4. Acessar o PostgreSQL**
Por padrão, o PostgreSQL cria um usuário chamado `postgres`. Você pode alternar para esse usuário e acessar o shell do PostgreSQL com os comandos:

```bash
sudo -i -u postgres
psql
```

No shell do PostgreSQL, você pode começar a executar comandos SQL. Por exemplo, para verificar a versão:

```sql
SELECT version();
```

Para sair do shell, digite:

```sql
\q
```

E para voltar ao seu usuário normal, digite:

```bash
exit
```

### **5. Configurar uma senha para o usuário `postgres`**
Ainda como o usuário `postgres`, configure uma senha para o banco:

```bash
sudo -i -u postgres
psql
```

Dentro do `psql`, use o seguinte comando para definir a senha:

```sql
ALTER USER postgres PASSWORD 'sua_senha_aqui';
```

Depois, saia:

```sql
\q
exit
```

### **6. Permitir conexões remotas (opcional)**
Se você planeja acessar o PostgreSQL remotamente:

1. **Editar o arquivo de configuração `pg_hba.conf`:**

   ```bash
   sudo nano /etc/postgresql/15/main/pg_hba.conf
   ```

   Substitua `local` ou `127.0.0.1` pela faixa de IP que você deseja permitir, ou use `0.0.0.0/0` para permitir conexões de qualquer lugar.

2. **Editar o arquivo `postgresql.conf`:**

   ```bash
   sudo nano /etc/postgresql/15/main/postgresql.conf
   ```

   Encontre a linha `listen_addresses` e altere para:

   ```conf
   listen_addresses = '*'
   ```

3. **Reiniciar o PostgreSQL:**

   ```bash
   sudo systemctl restart postgresql
   ```

### **7. Testar a instalação**
Crie um banco de dados de teste para garantir que tudo está funcionando corretamente:

1. Acesse o PostgreSQL:

   ```bash
   sudo -i -u postgres
   psql
   ```

2. Crie um banco de dados e um usuário:

   ```sql
   CREATE DATABASE teste;
   CREATE USER usuario_teste WITH PASSWORD 'sua_senha';
   GRANT ALL PRIVILEGES ON DATABASE teste TO usuario_teste;
   ```

3. Saia do shell:

   ```sql
   \q
   exit
   ```
