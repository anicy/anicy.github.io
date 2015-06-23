---
layout:  post
title:   "Q命令在csv和tsv上使用sql语句"
description:   "happy wife, happy life ..."
keywords:   q
category:   Study
tags:   [q] 
---


{% include JB/setup %}
```
q allows performing SQL-like statements on tabular text data. Its purpose is to bring SQL expressive power to the Linux command line and to provide easy access to text as actual data.

Query should be an SQL-like query which contains filenames instead of table names (or - for stdin). The query itself should be provided as one parameter to the tool (i.e. enclosed in quotes).

Use -H to signify that the input contains a header line. Column names will be detected automatically in that case, and can be used in the query. If this option is not provided, columns will be named cX, starting with 1 (e.g. q "SELECT c3,c8 from ...").

Use -d to specify the input delimiter.

Column types are auto detected by the tool, no casting is needed.

Please note that column names that include spaces need to be used in the query with back-ticks, as per the sqlite standard.

Query/Input/Output encodings are fully supported (and q tries to provide out-of-the-box usability in that area). Please use -e,-E and -Q to control encoding if needed.

All sqlite3 SQL constructs are supported, including joins across files (use an alias for each table).
See https://github.com/harelba/q for more details.
```
i.csv 文件
```
item_id,item_geohash,item_category
312051294,,8270
99999754,,7393
131746128,,7876
385731330,,10544
100004415,,3064
76588345,95qqvei,5411
312053799,,13547
100004955,,7033
312322681,,8376
```

```
cat i.csv | q -H -d ',' "select * from -"

312051294,,8270
99999754,,7393
131746128,,7876
385731330,,10544
100004415,,3064
76588345,95qqvei,5411
312053799,,13547
100004955,,7033
312322681,,8376

```
