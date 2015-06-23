---
title:   "phoenix data process"
description:   "happy wife, happy life ..."
keywords:   phoenix
category:   Project
tags:   [phoenix] 
---


{% include JB/setup %}


###orgin data

```java
粤XXXXX,2013/10/8 13:16:21,卡口——兴达路贤和路口,43,2,1
粤XXXXX,2013/10/8 13:16:23,卡口——兴达路贤和路口,45,2,2
粤XXXXX,2013/10/8 13:16:23,卡口——兴达路贤和路口,43,2,2
粤Y31D69,2013/10/8 13:16:32,卡口——兴达路贤和路口,35,2,1
粤ESV818,2013/10/8 13:16:36,卡口——兴达路贤和路口,50,2,2
粤EJM808,2013/10/8 13:16:46,卡口——兴达路贤和路口,45,2,1
粤E8J090,2013/10/8 13:16:46,卡口——兴达路贤和路口,50,2,1
粤EV330C,2013/10/8 13:16:49,卡口——兴达路贤和路口,46,2,2
粤EV3300,2013/10/8 13:16:49,卡口——兴达路贤和路口,44,2,1
粤E09836,2013/10/8 13:16:59,卡口——兴达路贤和路口,43,1,1
粤EV5436,2013/10/8 13:17:17,卡口——兴达路贤和路口,33,2,1
```


###sed replace
`sed  's/\//-/g' cheliu.csv > cheliuresult.csv`
```
粤ELQ311,2013-10-8 13:16:21,卡口——兴达路贤和路口,43,2,1
湘G12067,2013-10-8 13:16:23,卡口——兴达路贤和路口,45,2,2
湘G12067,2013-10-8 13:16:23,卡口——兴达路贤和路口,43,2,2
粤Y31D69,2013-10-8 13:16:32,卡口——兴达路贤和路口,35,2,1
粤ESV818,2013-10-8 13:16:36,卡口——兴达路贤和路口,50,2,2
粤EJM808,2013-10-8 13:16:46,卡口——兴达路贤和路口,45,2,1
粤E8J090,2013-10-8 13:16:46,卡口——兴达路贤和路口,50,2,1
粤EV330C,2013-10-8 13:16:49,卡口——兴达路贤和路口,46,2,2
粤EV3300,2013-10-8 13:16:49,卡口——兴达路贤和路口,44,2,1
粤E09836,2013-10-8 13:16:59,卡口——兴达路贤和路口,43,1,1
```

###add rowkey
`awk -F ',' '{printf("%d,%s\n",NR,$0)}' cheresult.csv > finresult.csv`

```
1,粤ELQ311,2013-10-8 13:16:21,卡口——兴达路贤和路口,43,2,1
2,湘G12067,2013-10-8 13:16:23,卡口——兴达路贤和路口,45,2,2
3,湘G12067,2013-10-8 13:16:23,卡口——兴达路贤和路口,43,2,2
4,粤Y31D69,2013-10-8 13:16:32,卡口——兴达路贤和路口,35,2,1
5,粤ESV818,2013-10-8 13:16:36,卡口——兴达路贤和路口,50,2,2
6,粤EJM808,2013-10-8 13:16:46,卡口——兴达路贤和路口,45,2,1
7,粤E8J090,2013-10-8 13:16:46,卡口——兴达路贤和路口,50,2,1
8,粤EV330C,2013-10-8 13:16:49,卡口——兴达路贤和路口,46,2,2
9,粤EV3300,2013-10-8 13:16:49,卡口——兴达路贤和路口,44,2,1
10,粤E09836,2013-10-8 13:16:59,卡口——兴达路贤和路口,43,1,1

```
###create table by phoenix on hbase

```sql
create table car2(
    id  bigint primary key,
    carnum varchar(20),
    time TIMESTAMP,
    kakou varchar(100),
    speed integer,
    color tinyint,
    style tinyint
)
```

###loading data to hbase

`$phoeix_home/bin/psql.py -t CAR2 master ../../data/cardata/finresult.csv`

###loading data by mapreduce 

```sql
create table carmr(
    id  bigint primary key,
    carnum varchar(20),
    time TIMESTAMP,
    kakou varchar(100),
    speed integer,
    color tinyint,
    style tinyint
)
```
upload to hdfs
```
hadoop fs -put finresult.csv  /phoenix
```
load data by mapreduce
```
HADOOP_CLASSPATH=/home/spark/soft/hbase/lib/hbase-protocol-0.98.8-hadoop2.jar:/home/spark/soft/hbase/conf hadoop jar phoenix-4.2.1-client.jar org.apache.phoenix.mapreduce.CsvBulkLoadTool --table CARMR --input /phoenix/finresult.csv 
```

![](http://needpp.qiniudn.com/2015/01/06/3149765e-954e-11e4-a385-f23c9156bf7b.png)

finish

![](http://needpp.qiniudn.com/2015/01/06/3235e70a-954e-11e4-a385-f23c9156bf7b.png)

check the data

![](http://needpp.qiniudn.com/2015/01/06/2e9a5194-954e-11e4-a385-f23c9156bf7b.png)

###append

####psql.py loader

```
Usage: psql [-t table-name] [-h comma-separated-column-names | in-line] <zookeeper>  <path-to-sql-or-csv-file>...
Example 1. Create table, upsert row and run query using single .sql file
./psql.py localhost <examples dir>/STOCK_SYMBOL.sql

Example 2. Create table, load CSV data and run queries using .csv and .sql files:
./psql.py localhost <examples dir>/WEB_STAT.sql <examples dir>/WEB_STAT.csv <examples dir>/WEB_STAT_QUERIES.sql

Note: Please see comments in WEB_STAT_QUERIES.sql for the sample queries being executed
```



####CSV MapReduce Loader
```
Usage: hadoop jar phoneix-[version]-mapreduce.jar <parameters>

 -a,--array-delimiter <arg>   Array element delimiter (optional)
 -c,--import-columns <arg>    Comma-separated list of columns to be
                              imported
 -d,--delimiter <arg>         Input delimiter, defaults to comma
 -g,--ignore-errors           Ignore input errors
 -h,--help                    Show this help and quit
 -i,--input <arg>             Input CSV path (mandatory)
 -o,--output <arg>            Output path for temporary HFiles (optional)
 -s,--schema <arg>            Phoenix schema name (optional)
 -t,--table <arg>             Phoenix table name (mandatory)
 -z,--zookeeper <arg>         Zookeeper quorum to connect to (optional)
```
