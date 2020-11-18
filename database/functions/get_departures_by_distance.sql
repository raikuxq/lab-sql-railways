CREATE OR REPLACE FUNCTION get_departures_by_distance(_from float, _to float)
    RETURNS TABLE
            (
                "from"     varchar,
                "to"       varchar,
                "distance" double precision
            )
AS
$func$
BEGIN
    RETURN QUERY
        SELECT d_from.name      AS "from",
               d_to.name        AS "to",
               pd.full_distance AS "distance"

        FROM departure

                 JOIN path ON departure.path_id = path.id
                 JOIN path_distance pd ON path.id = pd.path_id
                 JOIN destination d_from ON d_from.id = pd.from_id
                 JOIN destination d_to ON d_to.id = pd.to_id

        WHERE full_distance BETWEEN _from AND _to;

END
$func$ LANGUAGE plpgsql;