SELECT
    CONCAT(last_name, ' ', LEFT(first_name, 1), '.', LEFT(middle_name, 1), '.') as "lastname_with_initials"

FROM passenger