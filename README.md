# terraform-aws-cloudwatch-elasticache

This Terraform module configures multiple CloudWatch alarms for monitoring ElastiCache clusters, specifically targeting high CPU utilization, high connection count, high memory usage, high engine CPU usage, and high replication lag.

Each alarm triggers an alert to a specified SNS topic when a threshold is breached, enabling real-time notifications for critical issues.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create cloudwatch alarms for your EC2. You can use this module multiple times to create alarms with different configurations for various instances or metrics.

```python


################################################################################
# Cloudwatch Alarms for Elasticache
################################################################################


module "i-023de0ca96508cbde-alarms" {
  source            = "../"
  cache_cluster_id  = "i-023de0ca96508cbde"
  cache_node_id     = "0001"
  aws_sns_topic_arn = aws_sns_topic.opsgenie_topic.arn
  depends_on        = [aws_sns_topic.opsgenie_topic]

}


```

## information

This module includes the following types of alerts:

High CPU Utilization: Triggers when CPU usage exceeds the defined threshold.
High Connection Count: Triggers when connection count reaches high levels.
High Memory Usage: Triggers when memory usage exceeds the defined threshold.
High Engine CPU Usage: Triggers when engine CPU usage is too high.
High Replication Lag: Triggers when replication lag exceeds the defined threshold.

## Responding to Alerts

When an alert is triggered, check your SNS topic for a notification. Here are suggested actions for each alert type:

High CPU Utilization: Consider scaling your cluster or optimizing your workload.
High Connection Count: Investigate connection patterns and consider increasing the connection limit or implementing connection pooling.
High Memory Usage: Review memory usage patterns, consider optimizing the cache, or increasing memory capacity.
High Engine CPU Usage: Look into query performance and optimize heavy queries or spread load across multiple nodes.
High Replication Lag: Check the replication status and network health. You may need to increase the replication instance size or troubleshoot network bottlenecks.
