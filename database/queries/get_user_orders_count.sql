SELECT passenger_id,
       passenger_full_name,
       COUNT(passenger_id) AS "orders_count"

FROM ticket_user_info

GROUP BY passenger_id, passenger_full_name

ORDER BY passenger_id