# 索引的选择性是指，不重复的索引值和数据表的记录总数（#T）的比值，范围从1/#T~1之间。索引的选择性越高，查询效率越高。
# 以下是字符串列的所以长度选择方式,用于找出用于索引的合适字符串长度
SELECT COUNT(DISTINCT city)/COUNT(*) FROM sakila.city_demo; #计算完整列的选择性(也就是索引列所有数据的选择性，该选择性即为最优选择性)
# 列出5个长度的索引选择性，看是否接近上一句的执行结果，从而找出最理想的前缀索引长度
SELECT COUNT(DISTINCT LEFT(city< 3))/COUNT(*) AS sel3,
  COUNT(DISTINCT LEFT(city< 3))/COUNT(*) AS sel4
  COUNT(DISTINCT LEFT(city< 3))/COUNT(*) AS sel5
  COUNT(DISTINCT LEFT(city< 3))/COUNT(*) AS sel6,
  COUNT(DISTINCT LEFT(city< 3))/COUNT(*) AS sel7
FROM sakila.city_demo;
                      
# 多列索引的列顺序，选择性高的列放在前面
SELECT COUNT(DISTINCT staff_id)/COUNT(*) AS staff_id_selectivity,
COUNT(DISTINCT customer_id)/COUNT(*) AS customer_id_selectivity,
COUNT(*)
FROM payment;
****************** 1. row ************
                      staff_id_selectivity: 0.0001
                      customer_id_selectivity: 0.0373
                      COUNT(*): 16049
# customer_id的选择性更高，所以将其作为第一列
 ALTER TABLE payment ADD KEY(customer_id, staff_id);

# 查询重复或冗余索引的两个工具：
# 1. http://code.google.com/p/common-schema/
# 2. Percona Tookit中的 pt-duplicate-key-checker
                   
                      
# 查询未使用的索引
# 1. Maria DB中可以先打开userstates服务器变量（默认是关闭的），运行一段时间后在查询INFORMATION_SCHEMA.INDEX_STATISTICS就能查到每个索引的使用频率。
# 2. Percona Tookit中的 pt-index-usage可以读取查询日志，并对日志中的每条查询进行EXPLAIN操作，然后打印出关于索引和查询的报告。
