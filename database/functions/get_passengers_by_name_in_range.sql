CREATE OR REPLACE FUNCTION get_passengers_by_name_in_range(_from varchar, _to varchar)
    RETURNS TABLE
            (
                last_name varchar
            )
AS
$func$
BEGIN
    RETURN QUERY
        SELECT passenger.last_name
        FROM "passenger"
        WHERE LEFT(passenger.last_name, 1) BETWEEN _from AND _to
        GROUP BY passenger.last_name;

END
$func$ LANGUAGE plpgsql;