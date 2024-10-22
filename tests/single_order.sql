SELECT customer_id
FROM {{ ref('customers_materialized_table')}}
WHERE number_of_orders=1 and first_order<>most_recent_order