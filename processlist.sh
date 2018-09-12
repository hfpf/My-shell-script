# 1. SHOW PROCESSLIST\G 用于列出当前连接到mysql的连接（线程）及其线程的状态信息。
# SHOW FULL PROCESSLIST 可以用于显示每个查询的全文，否则最多显示100个字符
# 
mysql -e 'SHOW PROCESSLIST\G' | grep State: | sort | uniq -c | sort -rn
# 线程状态的名词解释: https://dev.mysql.com/doc/refman/5.6/en/general-thread-states.html
