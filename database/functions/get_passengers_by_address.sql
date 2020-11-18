create function get_passengers_by_address(_place character varying, _street character varying)
    returns TABLE(id integer, first_name character varying, last_name character varying, middle_name character varying, phone_number character varying, address text)
    language plpgsql
as
$$
BEGIN
    RETURN QUERY
        SELECT passenger.id,
               passenger.first_name,
               passenger.last_name,
               passenger.middle_name,
               passenger.phone_number,
               concat(a.country, ',', a.region,  ',', a.place,  ',', a.street,  ',', a.details) as "address"
        FROM "passenger"
                 JOIN address a ON passenger.address_id = a.id
        WHERE a.place LIKE _place
          AND a.street LIKE _street;

END
$$;
