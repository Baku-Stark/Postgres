# 🐘 | PostgreSQL - Triggers

**Triggers** são mecanismos no banco de dados que executam automaticamente uma ação específica (como uma função) em resposta a certos eventos, como **inserção**, **atualização** ou **exclusão** de dados em uma tabela. Eles são úteis para impor regras, validar dados ou realizar ações automáticas no banco de dados.

## Trigger para Garantir que Idade Seja Maior que 18

### **Explicação com o Exemplo Fornecido**

1. **Função `check_age()`**:  
   Esta função é criada para validar a idade de um cliente antes de ser inserido na tabela `Clients`.  
   - Se a idade do cliente (**`NEW.age`**) for menor que 18, a função dispara uma **exceção** (`RAISE EXCEPTION`) e impede que o registro seja adicionado.
   - Caso a idade seja válida, a função retorna o registro para ser processado normalmente.

   **Código da Função**:
   ```sql
   CREATE OR REPLACE FUNCTION check_age()
   RETURNS TRIGGER AS $$
   BEGIN
       IF NEW.age < 18 THEN
           RAISE EXCEPTION 'Client age must be 18 or older.';
       END IF;
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;
   ```

2. **Trigger `trigger_check_age`**:  
   O trigger associa a função `check_age()` à tabela `Clients` e especifica **quando** ela deve ser executada:  
   - **Evento:** Antes de um registro ser inserido (**BEFORE INSERT**).  
   - **Escopo:** Para cada linha sendo inserida (**FOR EACH ROW**).  

   **Código do Trigger**:
   ```sql
   CREATE TRIGGER trigger_check_age
   BEFORE INSERT ON public.Clients
   FOR EACH ROW
   EXECUTE FUNCTION check_age();
   ```

3. **Comportamento**:  
   Quando alguém tenta inserir um cliente na tabela `Clients`:
   - O trigger ativa automaticamente a função `check_age()`.
   - A função verifica se a idade é válida.
   - Se a idade for menor que 18, a operação é cancelada com uma mensagem de erro.

### **Por que usar Triggers?**
- **Automação**: Executam ações automaticamente, sem necessidade de intervenção manual.
- **Validação de Dados**: Garantem a consistência e integridade dos dados no banco.
- **Regra de Negócio**: Implementam regras diretamente no banco, independente da aplicação.

Neste exemplo, o trigger ajuda a implementar uma **regra de negócio simples**, garantindo que nenhum cliente com menos de 18 anos possa ser registrado.

### Input e Output

**Input**

```sql
INSERT INTO public.Clients (ID, name, age, gender, birth_date, created_at, Positions_ID)
VALUES 
(6, 'Alice Johnson', 17, 'F', '1994-05-15', '2024-12-22 10:00:00', 1);
```

A idade de `Alice Johnson` é menor que 18, logo, retornará um erro causado pelo trigger que vai impedir este tipo de inserção.

**Output**
```bash
org.jkiss.dbeaver.model.sql.DBSQLException: Erro SQL [P0001]: ERROR: Client age must be 18 or older.
  Onde: PL/pgSQL function check_age() line 4 at RAISE
	at org.jkiss.dbeaver.model.impl.jdbc.exec.JDBCStatementImpl.executeStatement(JDBCStatementImpl.java:130)
	at org.jkiss.dbeaver.ui.editors.sql.execute.SQLQueryJob.executeStatement(SQLQueryJob.java:631)
	at org.jkiss.dbeaver.ui.editors.sql.execute.SQLQueryJob.lambda$2(SQLQueryJob.java:522)
	at org.jkiss.dbeaver.ui.editors.sql.execute.SQLQueryJob.executeSingleQuery(SQLQueryJob.java:544)
	at org.jkiss.dbeaver.ui.editors.sql.execute.SQLQueryJob.extractData(SQLQueryJob.java:1016)
	at org.jkiss.dbeaver.ui.editors.sql.SQLEditor$QueryResultsContainer.readData(SQLEditor.java:4273)
	at org.jkiss.dbeaver.ui.controls.resultset.ResultSetJobDataRead.lambda$0(ResultSetJobDataRead.java:128)
	at org.jkiss.dbeaver.model.exec.DBExecUtils.tryExecuteRecover(DBExecUtils.java:192)
	at org.jkiss.dbeaver.ui.controls.resultset.ResultSetJobDataRead.run(ResultSetJobDataRead.java:126)
	at org.jkiss.dbeaver.ui.controls.resultset.ResultSetViewer$ResultSetDataPumpJob.run(ResultSetViewer.java:5017)
	at org.jkiss.dbeaver.model.runtime.AbstractJob.run(AbstractJob.java:119)
	at org.eclipse.core.internal.jobs.Worker.run(Worker.java:63)
Caused by: org.postgresql.util.PSQLException: ERROR: Client age must be 18 or older.
  Onde: PL/pgSQL function check_age() line 4 at RAISE
	at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2725)
	at org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2412)
	at org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:371)
	at org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:502)
	at org.postgresql.jdbc.PgStatement.execute(PgStatement.java:419)
	at org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:341)
	at org.postgresql.jdbc.PgStatement.executeCachedSql(PgStatement.java:326)
	at org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:302)
	at org.postgresql.jdbc.PgStatement.execute(PgStatement.java:297)
	at org.jkiss.dbeaver.model.impl.jdbc.exec.JDBCStatementImpl.execute(JDBCStatementImpl.java:344)
	at org.jkiss.dbeaver.model.impl.jdbc.exec.JDBCStatementImpl.executeStatement(JDBCStatementImpl.java:128)
	... 11 more
```


