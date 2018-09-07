# 1.
# 慢查询输出如下
# Query 1: 0 QPS 0x concurrency, ID 0xEE758C5E0D7EADEE at bytpe 3214 _____
# 表示可以通过字节偏移量(3214）直接跳转到日志文件的对应部分,如:
# tail -c +3214 /path/to/qurey.log | head -n100

# 2.
# pt-query-digest用法:(慢查询日志一般保存在mysql安装目录下的data文件中，如mac慢查询日志的所在目录：/usr/local/mysql/data）
# pt-query-digest slow.log 
