# ------------------------------------------------------------------------------
# Complete Example for RocketMQ Multi-Agent Communication Module
#
# This example demonstrates the basic usage of the RocketMQ multi-agent
# communication module with all necessary configurations.
# ------------------------------------------------------------------------------

# Configure the Alibaba Cloud Provider
provider "alicloud" {
  region = "cn-hangzhou"
}

# Query available zones for resource deployment
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

# Query available ECS images
data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

# Generate a random suffix for unique resource naming
resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

# Call the RocketMQ multi-agent communication module
module "rocketmq_multi_agent" {
  source = "../../"

  vpc_config = {
    cidr_block = var.vpc_cidr_block
    vpc_name   = "rocketmq-vpc-${random_string.suffix.result}"
  }

  vswitch_config = {
    cidr_block   = var.vswitch_cidr_block
    zone_id      = data.alicloud_zones.default.zones[0].id
    vswitch_name = "rocketmq-vswitch-${random_string.suffix.result}"
  }

  security_group_config = {
    security_group_name = "rocketmq-sg-${random_string.suffix.result}"
    description         = "Security group for RocketMQ multi-agent communication example"
  }

  instance_config = {
    instance_name              = "rocketmq-ecs-${random_string.suffix.result}"
    image_id                   = data.alicloud_images.default.images[0].id
    instance_type              = var.instance_type
    system_disk_category       = var.system_disk_category
    password                   = var.ecs_instance_password
    internet_max_bandwidth_out = var.internet_max_bandwidth_out
  }

  rocketmq_config = {
    msg_process_spec       = var.rocketmq_msg_process_spec
    message_retention_time = var.rocketmq_message_retention_time
    send_receive_ratio     = var.rocketmq_send_receive_ratio
    sub_series_code        = var.rocketmq_sub_series_code
    series_code            = var.rocketmq_series_code
    payment_type           = var.rocketmq_payment_type
    instance_name          = "ROCKETMQ5-${random_string.suffix.result}"
    service_code           = "rmq"
    internet_spec          = var.rocketmq_internet_spec
    flow_out_type          = var.rocketmq_flow_out_type
    acl_types              = var.rocketmq_acl_types
    default_vpc_auth_free  = var.rocketmq_default_vpc_auth_free
    tags                   = var.rocketmq_tags
  }
}