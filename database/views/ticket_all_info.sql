CREATE OR REPLACE VIEW ticket_all_info AS

SELECT
    /* Order common info */
    ticket.id                                                                     AS "ticket_id",

    /* Passenger info */
    p.id                                                                          AS "passenger_id",
    CONCAT(p.first_name, ' ', p.last_name, ' ', p.middle_name)                    AS "passenger_full_name ",
    CONCAT(a.country, ' ', a.place, ' ', a.region, ' ', a.street, ' ', a.details) AS "passenger_address",
    p.phone_number                                                                AS "passenger_phone_number",

    /* Departure info */
    dep.id                                                                        AS "departure_id",
    dep.departure_datetime                                                        AS "departure_in_datetime",
    d_from.id                                                                     AS "dest_from_id",
    d_from.name                                                                   AS "dest_from_name",
    dep.arrival_datetime                                                          AS "arrive_in_datetime",
    d_to.id                                                                       AS "dest_to_id",
    d_to.name                                                                     AS "dest_to_name",
    pd.full_distance                                                              AS "distance (km)",

    /* Train info */
    t.id                                                                          AS "train_id",
    t.number                                                                      AS "train_number",
    tt.id                                                                         AS "train_type_id",
    tt.type                                                                       AS "train_type_name",

    /* Carriage info */
    c.id                                                                          AS "carriage_id",
    ticket.carriage_number                                                        AS "carriage_number",
    ct.id                                                                         AS "carriage_type_id",
    ct.type                                                                       AS "carriage_type_name",
    ticket.seat_number                                                            AS "seat_number",

    /* Price */
    path.cost_per_km                                                              AS "cost_per_km",
    ticket.surcharge_for_urgency                                                  AS "surchage_for_urgency",
    tt.surcharge                                                                  AS "surcharge_for_train_type",
    ct.surcharge                                                                  AS "surchage_for_carriage_type"

FROM ticket

         JOIN passenger p ON p.id = ticket.passenger_id
         JOIN address a ON a.id = p.address_id
         JOIN departure dep ON dep.id = ticket.departure_id
         JOIN train t ON dep.train_id = t.id
         JOIN train_type tt ON t.train_type_id = tt.id
         JOIN train_carriage tc ON t.id = tc.train_id
         JOIN carriage c ON c.id = tc.carriage_id
         JOIN carriage_type ct ON ct.id = c.carriage_type_id
         JOIN path ON dep.path_id = path.id
         JOIN path_distance pd ON path.id = pd.path_id
         JOIN destination d_from ON d_from.id = pd.from_id
         JOIN destination d_to ON d_to.id = pd.to_id

WHERE ticket.carriage_number = tc.position

ORDER BY ticket.id, dep.departure_datetime, dep.arrival_datetime