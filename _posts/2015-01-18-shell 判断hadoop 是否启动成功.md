---
title:   "shell 判断hadoop 是否启动成功"
description:   "happy wife, happy life ..."
keywords:   shell,hadoop
category:   Note
tags:   [shell,hadoop] 
---


{% include JB/setup %}
```bash
#!/bin/bash
echo '启动hadoop环境'
#/home/spark/soft/hadoop-2.5.2/sbin/start-all.sh
echo '查看hadoop环境'


function h1(){

jps| awk '
BEGIN{count=0}
{
if($2=="NameNode" || $2=="SecondaryNameNode" || $2=="JobTracker"){
	count+=1
}
}
END{
if(count==3){
print("start v1 success")
}else {
print("v1 fail start")
}
}'
}


function h2(){

jps| awk '
BEGIN{count=0}
{
if($2=="NameNode" || $2=="SecondaryNameNode" || $2=="ResourceManager"){
	count+=1
}
}
END{
if(count==3){
print("start v2 success")
}else {
print("v2 fail start")
}
}'
}


version=`hadoop version | awk '{if(NR==1){print $2 }}' | cut -b 1`

echo $version
if [ $version -gt 1 ]; 
then
echo 'hadoop v2';
h2;
else 
echo 'hadoop v1';
h1;
fi;
```

```java
package edu.dcy.shell;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;

public class RunShellDemo {

	public static void main(String[] args) throws InterruptedException, IOException {
		try {
			
			Runtime rt=Runtime.getRuntime();
            Process process = rt.exec(new String[]{"/home/spark/test.sh","5","dd"});
            InputStreamReader ir = new InputStreamReader(process.getInputStream());
            LineNumberReader input = new LineNumberReader(ir);
            String line="";
            while((line = input.readLine()) != null)
                System.out.println(line);
            input.close();
            ir.close();
            int exitVal = process.waitFor(); 
//            System.out.println("exitval==="+exitVal);

            
        } catch (IOException e) {
            e.printStackTrace();
        }
		
	}
}
```
