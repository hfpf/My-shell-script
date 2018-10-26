# 将会话级别的计数器重置为0
FLUSH STATUS;
# 执行sql
select * from `sakila`.`nicer_but_slower_film_list`;
# 检查计数器的结果
SHOW STATUS WHERE Variable_name LIKE 'Handler%' OR Variable_name LIKE 'Created%';

# Shlomi Noach写的简介查询，用于查看变量的当前值和上一次查询的值，以及他们之间差值（也可以使用Percona Toolkit中的pt-mext工具）
SELECT STRAIGHT_JOIN 
	LOWER(gs0.VARIABLE_NAME) AS variable_name,
	gs0.VARIABLE_VALUE AS value_0,
	gs1.VARIABLE_VALUE AS value_1,
	(gs1.VARIABLE_VALUE - gs0.VARIABLE_VALUE) AS diff,
	(gs1.VARIABLE_VALUE - gs0.VARIABLE_VALUE) / 10 AS per_sec,
	(gs1.VARIABLE_VALUE - gs0.VARIABLE_VALUE) * 60 / 10 AS per_min
FROM (
	SELECT VARIABLE_NAME, VARIABLE_VALUE
	FROM INFORMATION_SCHEMA.GLOBAL_STATUS
	UNION ALL
	SELECT '', SLEEP(10) FROM DUAL
	) AS gs0
	JOIN INFORMATION_SCHEMA.GLOBAL_STATUS gs1 USING (VARIABLE_NAME)
WHERE gs1.VARIABLE_VALUE <> gs0.VARIABLE_VALUE;

# 服务器状态变量定义文档 https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html
#
# Handler_read_rnd_next
#
# The number of requests to read the next row in the data file. This value is high if you are doing a lot of table scans. Generally this suggests that your tables are not properly indexed or that your queries are not written to take advantage of the indexes you have.
#
# Created_tmp_disk_tables
#
# The number of internal on-disk temporary tables created by the server while executing statements.

