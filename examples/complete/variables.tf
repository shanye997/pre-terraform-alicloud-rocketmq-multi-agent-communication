# ------------------------------------------------------------------------------
# Variables for Complete Example
#
# This file defines input variables for the complete example of the
# RocketMQ multi-agent communication module.
# ------------------------------------------------------------------------------

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "The vpc_cidr_block must be a valid CIDR notation."
  }
}

variable "vswitch_cidr_block" {
  description = "The CIDR block for the VSwitch"
  type        = string
  default     = "192.168.1.0/24"

  validation {
    condition     = can(cidrhost(var.vswitch_cidr_block, 0))
    error_message = "The vswitch_cidr_block must be a valid CIDR notation."
  }
}

variable "instance_type" {
  description = "The ECS instance type"
  type        = string
  default     = "ecs.t6-c1m2.large"
}

variable "system_disk_category" {
  description = "The category of the system disk"
  type        = string
  default     = "cloud_essd"

  validation {
    condition     = contains(["cloud_efficiency", "cloud_ssd", "cloud_essd"], var.system_disk_category)
    error_message = "The system_disk_category must be one of: cloud_efficiency, cloud_ssd, cloud_essd."
  }
}

variable "ecs_instance_password" {
  description = "The password for ECS instance login (8-30 characters, must contain uppercase letters, lowercase letters, numbers, and special characters)"
  type        = string
  sensitive   = true
}

variable "internet_max_bandwidth_out" {
  description = "The maximum outbound bandwidth for the ECS instance"
  type        = number
  default     = 5
}

variable "rocketmq_msg_process_spec" {
  description = "The message processing specification for RocketMQ instance"
  type        = string
  default     = "rmq.s2.2xlarge"
}

variable "rocketmq_message_retention_time" {
  description = "The message retention time in hours for RocketMQ instance"
  type        = string
  default     = "70"
}

variable "rocketmq_send_receive_ratio" {
  description = "The send/receive ratio for RocketMQ instance"
  type        = string
  default     = "0.5"
}

variable "rocketmq_sub_series_code" {
  description = "The sub-series code for RocketMQ instance"
  type        = string
  default     = "cluster_ha"
}

variable "rocketmq_series_code" {
  description = "The series code for RocketMQ instance"
  type        = string
  default     = "standard"
}

variable "rocketmq_payment_type" {
  description = "The payment type for RocketMQ instance"
  type        = string
  default     = "PayAsYouGo"

  validation {
    condition     = contains(["PayAsYouGo", "Subscription"], var.rocketmq_payment_type)
    error_message = "The rocketmq_payment_type must be one of: PayAsYouGo, Subscription."
  }
}

variable "rocketmq_internet_spec" {
  description = "The internet specification for RocketMQ instance"
  type        = string
  default     = "disable"

  validation {
    condition     = contains(["enable", "disable"], var.rocketmq_internet_spec)
    error_message = "The rocketmq_internet_spec must be one of: enable, disable."
  }
}

variable "rocketmq_flow_out_type" {
  description = "The flow out type for RocketMQ instance"
  type        = string
  default     = "uninvolved"
}

variable "rocketmq_acl_types" {
  description = "The ACL types for RocketMQ instance"
  type        = list(string)
  default     = ["default", "apache_acl"]
}

variable "rocketmq_default_vpc_auth_free" {
  description = "Whether to enable default VPC authentication-free access for RocketMQ instance"
  type        = bool
  default     = false
}

variable "rocketmq_tags" {
  description = "The tags for RocketMQ instance"
  type        = map(string)
  default = {
    Environment = "example"
    Purpose     = "multi-agent-communication"
  }
}