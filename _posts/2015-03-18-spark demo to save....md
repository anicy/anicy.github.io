---
title:   "spark demo to save..."
description:   "happy wife, happy life ..."
keywords:   spark
category:   Note
tags:   [spark] 
---


{% include JB/setup %}
```
/**
 * Created by spark on 15-3-18.
 */
import org.apache.spark.SparkContext._
import org.apache.spark.{SparkContext, SparkConf}

/** Computes an approximation to pi */
object SparkDemo {
  def main(args: Array[String]) {
    if(args.length!=2){
      System.err.println("Usage : SparkDemo <input file> <output file >")
      System.exit(1)
    }
    val conf = new SparkConf().setMaster("local").setAppName("WordCount")
    val spark = new SparkContext(conf)

    val file=spark.textFile(args(0))
    val counts=file.map((_,1)).reduceByKey(_+_)
    counts.saveAsTextFile(args(1))
    spark.stop()
  }
}
```
