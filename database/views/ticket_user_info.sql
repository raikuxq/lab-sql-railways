CREATE OR REPLACE VIEW ticket_user_info AS

SELECT ticket.id                                                  AS "ticket_id",
       p.id                                                       AS "passenger_id",
       CONCAT(p.last_name, ' ', p.first_name, ' ', p.middle_name) AS "passenger_full_name",
       train.number                                               AS "train_number",
       tt.type                                                    AS "train_type",
       ticket.carriage_number                                     AS "carriage_number",
       ct.type                                                    AS "carriage_type",
       ticket.seat_number                                         AS "seat_number",
       ct.surcharge + tt.surcharge + ticket.surcharge_for_urgency +
       pd.full_distance * path.cost_per_km                        AS "total_price",
       d_from.name                                                AS "dest_from",
       d_to.name                                                  AS "dest_to",
       pd.full_distance                                           AS "full_distance"

FROM ticket

         JOIN departure dep ON ticket.departure_id = dep.id
         JOIN path ON dep.path_id = path.id
         JOIN path_distance pd ON path.id = pd.path_id
         JOIN destination d_from ON d_from.id = pd.from_id
         JOIN destination d_to ON d_to.id = pd.to_id
         JOIN train ON train.id = dep.train_id
         JOIN train_type tt ON train.train_type_id = tt.id
         JOIN train_carriage tc ON train.id = tc.train_id
         JOIN carriage c ON c.id = tc.carriage_id
         JOIN carriage_type ct ON ct.id = c.carriage_type_id
         JOIN passenger p ON p.id = ticket.passenger_id
         JOIN address a ON p.address_id = a.id

WHERE ticket.carriage_number = tc.position
