resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = var.high_cpu_enabled ? 1 : 0
  alarm_name          = "${var.cache_cluster_id}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
  alarm_description   = "Elasticache CPU utilization IN ${var.cache_cluster_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  datapoints_to_alarm = 5
  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
  tags = merge(var.tags, {
    "CacheClusterId" = var.cache_cluster_id,
    "Terraform"      = "true"
  })

}
resource "aws_cloudwatch_metric_alarm" "high_connection" {
  count               = var.high_connection_enabled ? 1 : 0
  alarm_name          = "${var.cache_cluster_id}-status-check-failed"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 10
  datapoints_to_alarm = 10
  metric_name         = "CurrConnections"
  namespace           = "AWS/ElastiCache"
  period              = 60
  statistic           = "Average"
  threshold           = (100 - var.high_connection_threshold) * 65000
  alarm_description   = "Average connections IN ${var.cache_cluster_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]

  dimensions = {
    CacheClusterId = var.cache_cluster_id
    CacheNodeId    = var.cache_node_id
  }
  tags = merge(var.tags, {
    "CacheClusterId" = var.cache_cluster_id,

    "Terraform" = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  count               = var.high_memory_enabled ? 1 : 0
  alarm_name          = "${var.cache_cluster_id}-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "DatabaseMemoryUsagePercentage"
  namespace           = "AWS/ElastiCache"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_memory_threshold
  alarm_description   = "Average memory IN ${var.cache_cluster_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]

  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
  tags = merge(var.tags, {
    "CacheClusterId" = var.cache_cluster_id,
    "Terraform"      = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_engine_cpu" {
  count               = var.high_engine_cpu_enabled ? 1 : 0
  alarm_name          = "${var.cache_cluster_id}-high-engine-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "EngineCPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 60
  statistic           = "Maximum"
  threshold           = var.high_engine_cpu_threshold
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
  tags = merge(var.tags, {
    "CacheClusterId" = var.cache_cluster_id,
    "Terraform"      = "true"
  })
  alarm_description = "Engine CPU IN ${var.cache_cluster_id} is too high"

}

resource "aws_cloudwatch_metric_alarm" "high_replication_lag" {
  count               = var.high_replication_lag_enabled ? 1 : 0
  alarm_name          = "${var.cache_cluster_id}-high-replication-lag"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "ReplicationLag"
  namespace           = "AWS/ElastiCache"
  period              = 60
  statistic           = "Maximum"
  threshold           = var.high_replication_lag_threshold
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  dimensions = {
    CacheClusterId = var.cache_cluster_id
  }
  tags = merge(var.tags, {
    "CacheClusterId" = var.cache_cluster_id,
    "Terraform"      = "true"
  })
  alarm_description = "Replication lag IN ${var.cache_cluster_id} is too high"

}
