SELECT passenger_id,
       passenger_full_name,
       SUM(total_price)

FROM ticket_user_info

GROUP BY passenger_id, passenger_full_name

ORDER BY passenger_id