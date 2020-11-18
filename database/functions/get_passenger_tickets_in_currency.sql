CREATE OR REPLACE FUNCTION get_passengers_tickets_in_currency(_train_number int, _currency numeric)
    RETURNS TABLE
            (
                train_number      int,
                passenger_name    text,
                total_price       double precision,
                price_in_currency numeric
            )
AS
$func$
BEGIN
    RETURN QUERY
        SELECT t.number                                                               AS "train_number",
               CONCAT(p.first_name, ' ', p.last_name)                                 AS "passenger_name",
               ticket_user_info.total_price                                           AS "total_price",
               round((ticket_user_info.total_price::numeric / _currency::numeric), 2) AS "price_in_currency"

        FROM ticket_user_info

                 JOIN ticket ON ticket.id = ticket_user_info.ticket_id
                 JOIN departure d ON d.id = ticket.departure_id
                 JOIN train t ON t.id = d.train_id
                 JOIN passenger p ON ticket.passenger_id = p.id

        WHERE t.number = _train_number;

END
$func$ LANGUAGE plpgsql;