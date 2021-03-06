# 当前会话启用查询性能剖析
set profiling = 1;
# 执行需要剖析的SQL
select * from `sakila`.`nicer_but_slower_film_list`;
# 显示所有使用性能剖析的查询及其Query_ID
show profiles;
# 显示Query_ID为1的查询的剖析报告
show profile for query 1;
# 格式化并排序输出查询剖析报告(SHOW PROFILE FOR QUERY n 的格式化输出方式）
set @query_id = 1;
select state,sum(duration) as total_R,
round( 100*sum(duration)/(select sum(duration) from information_schema.PROFILING where QUERY_ID=@query_id),2) as pct_R,
count(*) as calls,
sum(duration)/count(*) as 'r/call'
from information_schema.PROFILING
where QUERY_ID = @query_id
group by STATE
order by total_R desc;
# 关闭当前会话的查询性能剖析开关
set profiling = 0;
# INFORMATION_SCHEMA表文档 https://dev.mysql.com/doc/refman/5.7/en/profiling-table.html
