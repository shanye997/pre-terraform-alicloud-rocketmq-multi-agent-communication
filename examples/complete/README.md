# Complete Example for RocketMQ Multi-Agent Communication

This example demonstrates how to use the RocketMQ multi-agent communication module to create a complete infrastructure setup including VPC, VSwitch, Security Group, ECS instance, and RocketMQ instance.

## Architecture

This example creates the following resources:

- **VPC**: Provides an isolated network environment
- **VSwitch**: Creates a subnet within the VPC
- **Security Group**: Acts as a virtual firewall for network access control
- **ECS Instance**: Provides compute resources for running applications
- **RocketMQ Instance**: Enables asynchronous message communication between multiple agents

## Usage

To run this example, you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` when you no longer need these resources.

## Cost Estimation

This example will create the following billable resources:
- **VPC and VSwitch**: Free of charge
- **ECS Instance**: Charges based on instance type and running time (e.g., ecs.t6-c1m2.large)
- **RocketMQ Instance**: Charges based on specification and message processing capacity (e.g., rmq.s2.2xlarge)
- **Public Bandwidth**: Charges if internet bandwidth is enabled

Please refer to [Alibaba Cloud Pricing](https://www.alibabacloud.com/pricing) for detailed cost information.

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_cidr_block | The CIDR block for the VPC | `string` | `"192.168.0.0/16"` | no |
| vswitch_cidr_block | The CIDR block for the VSwitch | `string` | `"192.168.1.0/24"` | no |
| instance_type | The ECS instance type | `string` | `"ecs.t6-c1m2.large"` | no |
| system_disk_category | The category of the system disk | `string` | `"cloud_essd"` | no |
| ecs_password | The password for ECS instance login | `string` | n/a | yes |
| internet_max_bandwidth_out | The maximum outbound bandwidth for the ECS instance | `number` | `5` | no |
| rocketmq_msg_process_spec | The message processing specification for RocketMQ instance | `string` | `"rmq.s2.2xlarge"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the created VPC |
| vswitch_id | The ID of the created VSwitch |
| security_group_id | The ID of the created security group |
| ecs_instance_id | The ID of the created ECS instance |
| ecs_instance_public_ip | The public IP address of the ECS instance |
| ecs_instance_private_ip | The private IP address of the ECS instance |
| rocketmq_instance_id | The ID of the created RocketMQ instance |
| rocketmq_instance_name | The name of the created RocketMQ instance |
| rocketmq_instance_status | The status of the RocketMQ instance |
| rocketmq_endpoints | The access endpoints of the RocketMQ instance |
| region_id | The ID of the current region |

## Notes

- Make sure you have sufficient permissions to create the required resources in your Alibaba Cloud account.
- The ECS password must be 8-30 characters long and contain at least three types: uppercase letters, lowercase letters, numbers, and special characters.
- The RocketMQ instance will be created in PayAsYouGo mode by default. Change the `rocketmq_payment_type` variable if you prefer Subscription billing.
- All resources will be tagged appropriately for easy identification and management.

## Example terraform.tfvars

```hcl
vpc_cidr_block     = "192.168.0.0/16"
vswitch_cidr_block = "192.168.1.0/24"
instance_type      = "ecs.t6-c1m2.large"
ecs_password       = "YourSecurePassword123!"

rocketmq_msg_process_spec = "rmq.s2.2xlarge"
rocketmq_series_code      = "standard"
rocketmq_sub_series_code  = "cluster_ha"
```