# 加快ALTER TABLE操作速度的方法

# 1. 设置COLUMN的default值方式
使用:
ALTER TABLE sakila.film MODIFY COLUMN rental_duration TINYINT(3) NOT NULL DEFAULT 5;
代替:
ALTER TABLE sakila.film ALTER COLUMN rental_duration SET DEFAULT 5;

# 2. 只修改.frm文件（该方式不受官方认可，需要提前备份)
SHOW COLUMNS FROM `sakila`.`film` LIKE 'rating'; # 查看column

CREATE TABLE sakila.film_new LIKE sakila.film;

ALTER TABLE sakila.film_new
MODIFY COLUMN rating ENUM('G','PG','PG-13','R','NC-17', 'PG-14')
DEFAULT 'G';

FLUSH TABLES WITH READ LOCK; # 加锁

/usr/local/mysql/data/sakila# mv film.frm film_tmp.frm
/usr/local/mysql/data/sakila# mv film_new.frm film.frm
/usr/local/mysql/data/sakila# mv film_tmp.frm film_new.frm

UNLOCK TABLES; # 解锁

SHOW COLUMNS FROM sakila.film LIKE 'rating';

DROP TABLE sakila.film_new; # 删除老表
