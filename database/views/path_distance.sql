CREATE OR REPLACE VIEW path_distance AS
WITH paths AS (
    SELECT path.id
         , FIRST_VALUE(dFrom.id) OVER path_window   AS from_id
         , LAST_VALUE(dTo.id) OVER path_window      AS to_id
         , de.distance
    FROM path
             JOIN path_destination_edge AS pde
                  ON path.id = pde.path_id
             JOIN destination_edge AS de
                  ON de.id = pde.destination_edge_id
             JOIN destination AS dFrom
                  ON dFrom.id = de.destination_from_id
             JOIN destination AS dTo
                  ON dTo.id = de.destination_to_id
        WINDOW path_window AS (
            PARTITION BY path.id
            ORDER BY pde.position
            ROWS BETWEEN UNBOUNDED PRECEDING
                AND UNBOUNDED FOLLOWING
            )
    ORDER BY pde.position
)
SELECT id            AS "path_id"
     , from_id       AS "from_id"
     , to_id         AS "to_id"
     , SUM(distance) AS "full_distance"

FROM paths

GROUP BY id
       , from_id
       , to_id
ORDER BY id
;