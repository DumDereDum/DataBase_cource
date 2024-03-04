# Роли

В PostgreSQL роли играют важную роль в управлении безопасностью и доступом к базам данных. Роль в PostgreSQL определяет набор привилегий и прав доступа к базе данных или отдельным объектам внутри базы данных, таким как таблицы, представления и функции. Вот некоторые ключевые аспекты ролей в PostgreSQL:

1. **Роли пользователей**: Роли могут быть связаны с реальными пользователями базы данных, которые могут входить в систему и выполнять операции с данными.

2. **Роли групп**: Роли также могут быть группами других ролей. Это позволяет создавать наборы привилегий и разделять их между несколькими пользователями.

3. **Системные роли**: PostgreSQL поставляется с некоторыми встроенными системными ролями, такими как superuser (суперпользователь), который имеет полный доступ ко всем базам данных и объектам в них, и другие роли с различными уровнями привилегий.

4. **Управление доступом**: Роли используются для управления доступом к базам данных и их объектам. Это включает в себя назначение привилегий на чтение, запись, обновление и удаление данных.

5. **Создание и удаление ролей**: В PostgreSQL существуют команды для создания, удаления и модификации ролей, что позволяет администраторам баз данных управлять пользователями и их привилегиями.

Примеры команд для работы с ролями в PostgreSQL:

- `CREATE ROLE`: Создает новую роль в базе данных.
- `ALTER ROLE`: Изменяет параметры существующей роли.
- `DROP ROLE`: Удаляет роль из базы данных.
- `GRANT`: Предоставляет привилегии роли или пользователям.
- `REVOKE`: Отзывает привилегии у ролей или пользователей.

Пример использования ролей:

```sql
-- Создание роли
CREATE ROLE myrole WITH LOGIN PASSWORD 'mypassword';

-- Предоставление привилегий
GRANT SELECT, INSERT ON mytable TO myrole;

-- Предоставление привилегий группе
CREATE ROLE mygroup;
GRANT myrole TO mygroup;

-- Назначение роли текущему пользователю
SET ROLE myrole;
```

Роли в PostgreSQL позволяют эффективно управлять безопасностью и доступом к данным, обеспечивая гибкую систему контроля доступа к базам данных и объектам в них.

## Пример

Вот пример создания таблицы, создания роли и настройки прав доступа в PostgreSQL:

1. Создание таблицы:

```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);
INSERT INTO employees (first_name, last_name, email) VALUES
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Bob', 'Johnson', 'bob.johnson@example.com');
```

Этот SQL запрос создает таблицу `employees` с четырьмя столбцами: `employee_id`, `first_name`, `last_name` и `email`.

2. Создание роли:

```sql
CREATE ROLE readonly_user WITH LOGIN PASSWORD 'password';
```

Этот запрос создает роль `readonly_user` с паролем 'password'. Эта роль будет иметь право входа (LOGIN).

3. Настройка прав доступа:

```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
```

Этот запрос предоставляет роли `readonly_user` право только на SELECT (просмотр) для всех таблиц в схеме `public`.

4. Проверка:

Теперь пользователь, вошедший как `readonly_user`, сможет выполнять только операции SELECT на таблицу `employees`, но не сможет вносить изменения в неё:

### Postgresql Пример
```sql
-- Войти под ролью readonly_user
\c dbname readonly_user

-- Попытка обновления данных (это должно вызвать ошибку, так как у роли нет прав на обновление)
UPDATE employees SET first_name = 'John' WHERE employee_id = 1;

-- Просмотр данных
SELECT * FROM employees;
```

### Python Пример
```python
import psycopg2
from psycopg2 import sql

conn = psycopg2.connect(
        dbname="postgres",
        user="readonly_user",
        password="password",
        host="127.0.0.1",
        port="5432"
    )
cur = conn.cursor()

cur.execute("SELECT * FROM employees;")
[print(row) for row in cur.fetchall()]

try: 
    cur.execute("UPDATE employees SET first_name = 'John' WHERE employee_id = 1;")
    conn.commit()
except psycopg2.Error as e:
    print("Ошибка: ", e)

cur.execute("SELECT * FROM users;")

```

Таким образом, вы создали роль, которая имеет только права на просмотр данных в таблице `employees`, но не имеет прав на их изменение.