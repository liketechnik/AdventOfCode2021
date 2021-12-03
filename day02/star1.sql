WITH
    forward_total AS (SELECT SUM(amount) AS forward_total FROM aoc_day2_input WHERE direction = 'forward' GROUP BY direction),
    down_total AS (SELECT SUM(amount) AS down_total FROM aoc_day2_input WHERE direction = 'down' GROUP BY direction),
    up_total AS (SELECT SUM(amount) AS up_total FROM aoc_day2_input WHERE direction = 'up' GROUP BY direction),
    depth AS (SELECT down_total.down_total - up_total.up_total AS depth FROM down_total, up_total)
SELECT 
    forward_total.forward_total AS horizontal_position,
    down_total.down_total AS down_total,
    up_total.up_total AS up_total,
    depth.depth AS depth,
    depth * forward_total.forward_total AS result
FROM
    forward_total, down_total, up_total, depth;

