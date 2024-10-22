SELECT customer_id
FROM {{ ref('customers_materialized_table')}}
WHERE first_order > most_recent_order