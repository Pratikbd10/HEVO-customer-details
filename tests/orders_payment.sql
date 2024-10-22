SELECT customer_id
FROM {{ ref('customers_materialized_table')}}
WHERE number_of_orders=0 and customer_lifetime_value <> 0