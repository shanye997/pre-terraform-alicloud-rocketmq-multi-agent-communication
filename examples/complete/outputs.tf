# ------------------------------------------------------------------------------
# Outputs for Complete Example
#
# This file defines the outputs for the complete example, which display
# important information about the created resources.
# ------------------------------------------------------------------------------

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.rocketmq_multi_agent.vpc_id
}

output "vswitch_id" {
  description = "The ID of the created VSwitch"
  value       = module.rocketmq_multi_agent.vswitch_id
}

output "security_group_id" {
  description = "The ID of the created security group"
  value       = module.rocketmq_multi_agent.security_group_id
}

output "ecs_instance_id" {
  description = "The ID of the created ECS instance"
  value       = module.rocketmq_multi_agent.ecs_instance_id
}

output "ecs_instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = module.rocketmq_multi_agent.ecs_instance_public_ip
}

output "ecs_instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = module.rocketmq_multi_agent.ecs_instance_private_ip
}

output "rocketmq_instance_id" {
  description = "The ID of the created RocketMQ instance"
  value       = module.rocketmq_multi_agent.rocketmq_instance_id
}

output "rocketmq_instance_name" {
  description = "The name of the created RocketMQ instance"
  value       = module.rocketmq_multi_agent.rocketmq_instance_name
}

output "rocketmq_instance_status" {
  description = "The status of the RocketMQ instance"
  value       = module.rocketmq_multi_agent.rocketmq_instance_status
}

output "rocketmq_endpoints" {
  description = "The access endpoints of the RocketMQ instance"
  value       = module.rocketmq_multi_agent.rocketmq_endpoints
}
