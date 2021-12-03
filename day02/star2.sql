WITH RECURSIVE previous AS (
        SELECT 1 AS id, 0 AS aim, 0 AS horizontal, 0 AS depth
    UNION
        SELECT 
            previous.id + 1 AS id,
            previous.aim - GREATEST(up.amount, 0) + GREATEST(down.amount, 0) AS aim,
            previous.horizontal + GREATEST(forward.amount, 0) AS horizontal,
            previous.depth + (previous.aim * GREATEST(forward.amount, 0)) AS depth
        FROM aoc_day2_input AS id_table 
        INNER JOIN previous ON previous.id = id_table.id
        LEFT OUTER JOIN aoc_day2_input AS up ON id_table.id = up.id AND up.direction = 'up'
        LEFT OUTER JOIN aoc_day2_input AS down ON id_table.id = down.id AND down.direction = 'down'
        LEFT OUTER JOIN aoc_day2_input AS forward ON id_table.id = forward.id AND forward.direction = 'forward'
)
SELECT previous.horizontal AS horizontal_position, previous.depth AS depth, depth * previous.horizontal AS result 
FROM previous WHERE id = (SELECT MAX(id) + 1 FROM aoc_day2_input); -- show only last row, technically the WHERE clause is not necessary for a correct result

