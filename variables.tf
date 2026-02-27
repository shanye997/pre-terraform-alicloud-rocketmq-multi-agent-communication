# ------------------------------------------------------------------------------
# Module Input Variables
#
# This file defines all configurable input variables for the Terraform module.
# Each variable includes detailed description, type definition, and default values
# to help users understand and configure the module correctly.
# ------------------------------------------------------------------------------

variable "vpc_config" {
  description = "Configuration for VPC. The 'cidr_block' attribute is required."
  type = object({
    cidr_block = string
    vpc_name   = optional(string, "rocketmq-vpc")
  })
}

variable "vswitch_config" {
  description = "Configuration for VSwitch. The 'cidr_block' and 'zone_id' attributes are required."
  type = object({
    cidr_block   = string
    zone_id      = string
    vswitch_name = optional(string, "rocketmq-vswitch")
  })
}

variable "security_group_config" {
  description = "Configuration for security group."
  type = object({
    security_group_name = optional(string, "rocketmq-sg")
    description         = optional(string, "Security group for RocketMQ multi-agent communication")
  })
  default = {}
}

variable "instance_config" {
  description = "Configuration for ECS instance. The 'image_id', 'instance_type', 'system_disk_category', and 'password' attributes are required."
  type = object({
    instance_name              = optional(string, "rocketmq-ecs")
    image_id                   = string
    instance_type              = string
    system_disk_category       = string
    password                   = string
    internet_max_bandwidth_out = optional(number, 5)
  })
}

variable "rocketmq_config" {
  description = "Configuration for RocketMQ instance. The 'msg_process_spec', 'instance_name', and 'service_code' attributes are required."
  type = object({
    msg_process_spec       = string
    message_retention_time = optional(string, "70")
    send_receive_ratio     = optional(string, "0.5")
    sub_series_code        = optional(string, "cluster_ha")
    series_code            = optional(string, "standard")
    payment_type           = optional(string, "PayAsYouGo")
    instance_name          = string
    service_code           = string
    internet_spec          = optional(string, "disable")
    flow_out_type          = optional(string, "uninvolved")
    acl_types              = optional(list(string), ["default", "apache_acl"])
    default_vpc_auth_free  = optional(bool, false)
    tags                   = optional(map(string), {})
  })
}
