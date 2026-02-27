# ------------------------------------------------------------------------------
# Main Resource Definitions
#
# This file contains the core infrastructure resources for the module.
# It creates resources based on input variables and organizes them according to
# best practices for maintainability and reusability.
# ------------------------------------------------------------------------------


# Create VPC (Virtual Private Cloud) to provide isolated network environment
resource "alicloud_vpc" "this" {
  cidr_block = var.vpc_config.cidr_block
  vpc_name   = var.vpc_config.vpc_name
}

# Create VSwitch within the VPC for subnet configuration
resource "alicloud_vswitch" "this" {
  vpc_id       = alicloud_vpc.this.id
  cidr_block   = var.vswitch_config.cidr_block
  zone_id      = var.vswitch_config.zone_id
  vswitch_name = var.vswitch_config.vswitch_name
}

# Create security group as virtual firewall for network access control
resource "alicloud_security_group" "this" {
  vpc_id              = alicloud_vpc.this.id
  security_group_name = var.security_group_config.security_group_name
  description         = var.security_group_config.description
}

# Create ECS instance (Elastic Compute Service)
resource "alicloud_instance" "this" {
  instance_name              = var.instance_config.instance_name
  image_id                   = var.instance_config.image_id
  instance_type              = var.instance_config.instance_type
  system_disk_category       = var.instance_config.system_disk_category
  security_groups            = [alicloud_security_group.this.id]
  vswitch_id                 = alicloud_vswitch.this.id
  password                   = var.instance_config.password
  internet_max_bandwidth_out = var.instance_config.internet_max_bandwidth_out
}

# Create RocketMQ instance for multi-agent asynchronous communication
resource "alicloud_rocketmq_instance" "this" {
  product_info {
    msg_process_spec       = var.rocketmq_config.msg_process_spec
    message_retention_time = var.rocketmq_config.message_retention_time
    send_receive_ratio     = var.rocketmq_config.send_receive_ratio
  }

  sub_series_code = var.rocketmq_config.sub_series_code
  series_code     = var.rocketmq_config.series_code
  payment_type    = var.rocketmq_config.payment_type
  instance_name   = var.rocketmq_config.instance_name
  service_code    = var.rocketmq_config.service_code

  network_info {
    vpc_info {
      vpc_id = alicloud_vpc.this.id
      vswitches {
        vswitch_id = alicloud_vswitch.this.id
      }
    }
    internet_info {
      internet_spec = var.rocketmq_config.internet_spec
      flow_out_type = var.rocketmq_config.flow_out_type
    }
  }

  acl_info {
    acl_types             = var.rocketmq_config.acl_types
    default_vpc_auth_free = var.rocketmq_config.default_vpc_auth_free
  }

  tags = var.rocketmq_config.tags
}