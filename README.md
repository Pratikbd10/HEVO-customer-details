### Steps while doing HEVO Assessment

### Creating Postgres Ready using docker image.

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
    psql -h {{host}} -p 5432 -U hevo_user -d hevo_database
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
* Configure the database to be accessible to external users too by making appropriate changes inside config files, those are "postgresql.conf" and "pg_hba.conf"
====================
### Building and running the dbt project.
* Run the following command at the desired folder, where you want to create the dbt project.
```cmd
    dbt init
```
* This will create a project and ask for the warehouse and database details.
* After providing those things the project will be linked to the database.
* We can directly create models.
* Create testcases for data quality checkups.
* We can use following command to run the models.
```cmd
    dbt run
```
* We can run the following command to run the test cases over the model.
```cmd
    dbt test
```

* If all the tests pass, then we are good to go.