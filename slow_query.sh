# 1.
# 慢查询输出如下
# Query 1: 0 QPS 0x concurrency, ID 0xEE758C5E0D7EADEE at bytpe 3214 _____
# 表示可以通过字节偏移量(3214）直接跳转到日志文件的对应部分,如:
# tail -c +3214 /path/to/qurey.log | head -n100

# 2.
# pt-query-digest用法:(慢查询日志一般保存在mysql安装目录下的data文件中，如mac慢查询日志的所在目录：/usr/local/mysql/data）
# pt-query-digest slow.log 

######以下为诊断间歇性问题的方法##########

# 3. 一秒执行一次 SHOW GLOBAL STATUS命令捕获数据，通过计数器数据的峰谷来发现问题。
mysqladmin ext -i1 | awk '
/Queries/{q=$4-qp;qp=$4}    // 变量qp中保存的是上一次结果，默认为0
/Threads_connected/{tc=$4}
/Threads_running/{printf "%5d %5d %5d\n", q, tc, $4}'

# 4. 根据慢查日志，统计每秒的查询数量
$ awk '/^# Time:/{print $3, $4, c;c=0}/^# User/{c++}' slow-query.log 080913 21:52:17 51
080913 21:52:18 29
080913 21:52:19 34
080913 21:52:20 33 
080913 21:52:21 38 
