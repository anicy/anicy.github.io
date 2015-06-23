---
layout:  post
title:   "maven mirror bak"
description:   "happy wife, happy life ..."
keywords:   maven
category:   Note
tags:   [maven] 
---


{% include JB/setup %}
- mirror
```
<mirror>
        <id>nexus-osc</id>
         <mirrorOf>*</mirrorOf>
     <name>Nexusosc</name>
     <url>http://maven.oschina.net/content/groups/public/</url>
 </mirror>
```


- profile
```
<profile>
       <id>jdk-1.7</id>
       <activation>
         <jdk>1.7</jdk>
       </activation>
       <repositories>
         <repository>
           <id>nexus</id>
           <name>local private nexus</name>
           <url>http://maven.oschina.net/content/groups/public/</url>
           <releases>
             <enabled>true</enabled>
           </releases>
           <snapshots>
             <enabled>false</enabled>
           </snapshots>
         </repository>
       </repositories>
       <pluginRepositories>
         <pluginRepository>
           <id>nexus</id>
          <name>local private nexus</name>
           <url>http://maven.oschina.net/content/groups/public/</url>
           <releases>
             <enabled>true</enabled>
           </releases>
           <snapshots>
             <enabled>false</enabled>
           </snapshots>
         </pluginRepository>
       </pluginRepositories>
 </profile>
```
