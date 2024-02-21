# Связывание таблиц

Таблицы в базах данных могут быть связаны между собой с помощью внешних ключей. Внешний ключ в одной таблице связывается с первичным ключом (обычно) в другой таблице. Это позволяет создавать зависимости между данными в таблицах.

Команда REFERENCES в SQL используется для создания внешнего ключа, который связывает поле в одной таблице с полем в другой таблице. Это позволяет создавать связи между данными в разных таблицах и обеспечивать целостность данных.

Пример правильной вставки данных:

Предположим, у нас есть две таблицы: "users" (пользователи) и "orders" (заказы). Каждый заказ принадлежит определенному пользователю. Вот как это может выглядеть в SQL:

```SQL
CREATE TABLE users_tmp (
    user_id INT PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE orders_tmp (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES users_tmp(user_id)
);

-- Заполнение таблицы users
INSERT INTO users_tmp (user_id, username) VALUES
(1, 'user1_name'),
(2, 'user2_name'),
(3, 'user3_name'),
(4, 'user4_name'),
(5, 'user5_name');

-- Заполнение таблицы orders
INSERT INTO orders_tmp (order_id, user_id, order_date) VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-02-02'),
(3, 3, '2024-02-03'),
(4, 1, '2024-02-04'),
(5, 4, '2024-02-05'),
(6, 2, '2024-02-06'),
(7, 5, '2024-02-07'),
(8, 3, '2024-02-08'),
(9, 1, '2024-02-09'),
(10, 4, '2024-02-10');
```


```SQL
INSERT INTO orders_tmp (order_id, user_id, order_date) VALUES (20, 20, '2024-02-01')
-- ERROR:  Key (user_id)=(20) is not present in table "users_tmp".insert or update on table "orders_tmp" violates foreign key constraint "orders_tmp_user_id_fkey" 
-- ERROR:  insert or update on table "orders_tmp" violates foreign key constraint "orders_tmp_user_id_fkey"
-- SQL state: 23503
-- Detail: Key (user_id)=(20) is not present in table "users_tmp".
```