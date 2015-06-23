---
title:   "Hive use mysql as meta db"
description:   "happy wife, happy life ..."
keywords:   hive,mysql
category:   Study
tags:   [hive,mysql] 
---


{% include JB/setup %}
```xml

<property>
  <name>hive.metastore.warehouse.dir</name>
  <value>/hive/warehouse</value>
  <description>location of default database for the warehouse</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionURL</name>
  <value>jdbc:mysql://localhost:3306/hive_hdp?characterEncoding=UTF-8&amp;createDatabaseIfNotExist=true</value>
  <description>JDBC connect string for a JDBC metastore</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionDriverName</name>
  <value>com.mysql.jdbc.Driver</value>
  <description>Driver class name for a JDBC metastore</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionUserName</name>
  <value>root</value>
  <description>username to use against metastore database</description>
</property>

<property>
  <name>javax.jdo.option.ConnectionPassword</name>
  <value>q1w2e3r4</value>
  <description>password to use against metastore database</description>
</property>

</configuration>
```
