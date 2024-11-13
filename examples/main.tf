provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "opsgenie_topic" {
  name         = "opsgenie"
  display_name = "opsgenie"
}

resource "aws_sns_topic_subscription" "opsgenie_subscription" {
  confirmation_timeout_in_minutes = 1
  endpoint_auto_confirms          = false
  topic_arn                       = aws_sns_topic.opsgenie_topic.arn
  protocol                        = "https"
  endpoint                        = "https://api.opsgenie.com/v1/xxx"
  depends_on                      = [aws_sns_topic.opsgenie_topic]
}

module "i-023de0ca96508cbde-alarms" {
  source            = "../"
  cache_cluster_id  = "i-023de0ca96508cbde"
  cache_node_id     = "0001"
  aws_sns_topic_arn = aws_sns_topic.opsgenie_topic.arn
  depends_on        = [aws_sns_topic.opsgenie_topic]

}




