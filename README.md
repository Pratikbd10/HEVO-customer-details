### Steps while doing HEVO Assessment
* Pulling postrgres image
```cmd
docker pull postgres
```

* Running the image
```cmd
docker run --name hevo_assesment_postgres -e POSTGRES_PASSWORD=XXXXXXXXXXXXXX -e POSTGRES_USER=hevo_user -e POSTGRES_DB=hevo_database -p 5432:5432 -d postgres
```

* Accessing the database
```cmd
psql -h 192.168.56.103 -p 5432 -U hevo_user -d hevo_database
```

* Creating tables
```cmd
create table raw_customers (id SERIAL PRIMARY KEY, first_name VARCHAR(100), last_name VARCHAR(100));

CREATE TABLE raw_orders (id SERIAL PRIMARY KEY,user_id INT,order_date DATE,status VARCHAR(50), CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES raw_customers(id) ON DELETE CASCADE);

CREATE TABLE raw_payments (id SERIAL PRIMARY KEY,order_id INT,payment_method VARCHAR(50),amount INT, CONSTRAINT fk_user FOREIGN KEY(order_id) REFERENCES raw_orders(id) ON DELETE CASCADE);

```
* Load files in the database
```cmd
COPY raw_customers(id, first_name, last_name) FROM '/raw_customers.csv' DELIMITER ',' CSV HEADER;

COPY raw_orders(id, user_id, order_date, status) FROM '/raw_orders.csv' DELIMITER ',' CSV HEADER;

COPY raw_payments(id, order_id, payment_method, amount) FROM '/raw_payments.csv' DELIMITER ',' CSV HEADER;

```
