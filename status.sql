# 将会话级别的计数器重置为0
FLUSH STATUS;
# 执行sql
select * from `sakila`.`nicer_but_slower_film_list`;
# 检查计数器的结果
SHOW STATUS WHERE Variable_name LIKE 'Handler%' OR Variable_name LIKE 'Created%';

# 服务器状态变量定义文档 https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html
#
# Handler_read_rnd_next
#
# The number of requests to read the next row in the data file. This value is high if you are doing a lot of table scans. Generally this suggests that your tables are not properly indexed or that your queries are not written to take advantage of the indexes you have.
#
# Created_tmp_disk_tables
#
# The number of internal on-disk temporary tables created by the server while executing statements.
