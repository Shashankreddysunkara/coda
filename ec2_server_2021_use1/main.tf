#AWS Instance
resource "aws_instance" "example" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    availability_zone = var.availability_zone
  
  lifecycle {
    ignore_changes = [ami]
  }
}

#AMI Filter for ubuntu 18.04 Base
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["528922625383"] # Canonical
}

#EBS Volume and Attachment

resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  size              = 40
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.example.id
}

#Cloudwatch Metric

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2" 
  period                    = "120" #seconds
  statistic                 = "Average"
  threshold                 = "80" 
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
        InstanceId = aws_instance.example.id
      }

  resource "aws_lambda_function" "rds-events" {
    filename = "${data.archive_file.start_scheduler.output_path}"
    function_name = "rds-events"
    description = "Capture RDS event for lambda target"
      event_pattern = <<pattern
      {
        "source": [
          "aws.rds"
          ],
          "detail-type": [
            "RDS DB Instance Event"
          ],
          "detail": {
            "EventCategories": [
              "failover"
            ]
          }

  resource "aws_cloudwatch_event_target" "lambda" {
    rule = "${aws_cloudwatch_event_rule.test-RDS-event.name}"
    target_id = "populate_NLB_TG_with_RDS"
    arn = "${aws_lambda_function.rds-events.arn}"
  }
}