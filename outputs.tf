# ------------------------------------------------------------------------------
# Module Output Values
#
# This file defines the output values that this Terraform module returns.
# These outputs can be referenced by other Terraform configurations or displayed
# to users after successful deployment.
# ------------------------------------------------------------------------------

output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.this.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.this.cidr_block
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.this.id
}

output "vswitch_cidr_block" {
  description = "The CIDR block of the VSwitch"
  value       = alicloud_vswitch.this.cidr_block
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.this.id
}

output "ecs_instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.this.id
}

output "ecs_instance_name" {
  description = "The name of the ECS instance"
  value       = alicloud_instance.this.instance_name
}

output "ecs_instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = alicloud_instance.this.public_ip
}

output "ecs_instance_private_ip" {
  description = "The primary private IP address of the ECS instance"
  value       = alicloud_instance.this.primary_ip_address
}

output "rocketmq_instance_id" {
  description = "The ID of the RocketMQ instance"
  value       = alicloud_rocketmq_instance.this.id
}

output "rocketmq_instance_name" {
  description = "The name of the RocketMQ instance"
  value       = alicloud_rocketmq_instance.this.instance_name
}

output "rocketmq_instance_status" {
  description = "The status of the RocketMQ instance"
  value       = alicloud_rocketmq_instance.this.status
}

output "rocketmq_endpoints" {
  description = "The access endpoints of the RocketMQ instance"
  value       = alicloud_rocketmq_instance.this.network_info[0].endpoints
}