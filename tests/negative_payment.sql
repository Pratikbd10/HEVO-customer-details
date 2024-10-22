SELECT customer_id
FROM {{ ref('customers_materialized_table')}}
WHERE customer_lifetime_value < 0