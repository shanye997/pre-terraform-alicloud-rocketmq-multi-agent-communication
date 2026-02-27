RocketMQ 多智能体通信 Terraform 模块

================================================ 

# terraform-alicloud-rocketmq-multi-agent-communication

[English](https://github.com/alibabacloud-automation/terraform-alicloud-rocketmq-multi-agent-communication/blob/main/README.md) | 简体中文

在阿里云上创建 RocketMQ 多智能体异步通信完整基础设施的 Terraform 模块。该模块实现了[通过 RocketMQ 实现多智能体异步通信](https://www.aliyun.com/solution/tech-solution-deploy/2990228)的解决方案，涉及专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、安全组和 RocketMQ 实例等资源的创建和部署，以实现多个智能体之间高效的基于消息的通信。

## 使用方法

该模块提供了建立基于 RocketMQ 的多智能体通信基础设施的完整解决方案。只需提供所需的配置参数，模块将创建包括网络基础设施和消息服务在内的所有必要资源。

```terraform
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = "ecs.t6-c1m2.large"
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

module "rocketmq_multi_agent" {
  source = "alibabacloud-automation/rocketmq-multi-agent-communication/alicloud"

  vpc_config = {
    cidr_block = "192.168.0.0/16"
  }

  vswitch_config = {
    cidr_block = "192.168.1.0/24"
    zone_id    = data.alicloud_zones.default.zones[0].id
  }

  instance_config = {
    image_id             = data.alicloud_images.default.images[0].id
    instance_type        = "ecs.t6-c1m2.large"
    system_disk_category = "cloud_essd"
    password             = "YourSecurePassword123!"
  }

  rocketmq_config = {
    msg_process_spec = "rmq.s2.2xlarge"
    instance_name    = "ROCKETMQ5-multiagent"
    service_code     = "rmq"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-rocketmq-multi-agent-communication/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_instance.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_rocketmq_instance.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rocketmq_instance) | resource |
| [alicloud_security_group.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | Configuration for ECS instance. The 'image\_id', 'instance\_type', 'system\_disk\_category', and 'password' attributes are required. | <pre>object({<br/>    instance_name              = optional(string, "rocketmq-ecs")<br/>    image_id                   = string<br/>    instance_type              = string<br/>    system_disk_category       = string<br/>    password                   = string<br/>    internet_max_bandwidth_out = optional(number, 5)<br/>  })</pre> | n/a | yes |
| <a name="input_rocketmq_config"></a> [rocketmq\_config](#input\_rocketmq\_config) | Configuration for RocketMQ instance. The 'msg\_process\_spec', 'instance\_name', and 'service\_code' attributes are required. | <pre>object({<br/>    msg_process_spec       = string<br/>    message_retention_time = optional(string, "70")<br/>    send_receive_ratio     = optional(string, "0.5")<br/>    sub_series_code        = optional(string, "cluster_ha")<br/>    series_code            = optional(string, "standard")<br/>    payment_type           = optional(string, "PayAsYouGo")<br/>    instance_name          = string<br/>    service_code           = string<br/>    internet_spec          = optional(string, "disable")<br/>    flow_out_type          = optional(string, "uninvolved")<br/>    acl_types              = optional(list(string), ["default", "apache_acl"])<br/>    default_vpc_auth_free  = optional(bool, false)<br/>    tags                   = optional(map(string), {})<br/>  })</pre> | n/a | yes |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | Configuration for security group. | <pre>object({<br/>    security_group_name = optional(string, "rocketmq-sg")<br/>    description         = optional(string, "Security group for RocketMQ multi-agent communication")<br/>  })</pre> | `{}` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration for VPC. The 'cidr\_block' attribute is required. | <pre>object({<br/>    cidr_block = string<br/>    vpc_name   = optional(string, "rocketmq-vpc")<br/>  })</pre> | n/a | yes |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | Configuration for VSwitch. The 'cidr\_block' and 'zone\_id' attributes are required. | <pre>object({<br/>    cidr_block   = string<br/>    zone_id      = string<br/>    vswitch_name = optional(string, "rocketmq-vswitch")<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_instance_id"></a> [ecs\_instance\_id](#output\_ecs\_instance\_id) | The ID of the ECS instance |
| <a name="output_ecs_instance_name"></a> [ecs\_instance\_name](#output\_ecs\_instance\_name) | The name of the ECS instance |
| <a name="output_ecs_instance_private_ip"></a> [ecs\_instance\_private\_ip](#output\_ecs\_instance\_private\_ip) | The primary private IP address of the ECS instance |
| <a name="output_ecs_instance_public_ip"></a> [ecs\_instance\_public\_ip](#output\_ecs\_instance\_public\_ip) | The public IP address of the ECS instance |
| <a name="output_region_id"></a> [region\_id](#output\_region\_id) | The ID of the current region |
| <a name="output_rocketmq_endpoints"></a> [rocketmq\_endpoints](#output\_rocketmq\_endpoints) | The access endpoints of the RocketMQ instance |
| <a name="output_rocketmq_instance_id"></a> [rocketmq\_instance\_id](#output\_rocketmq\_instance\_id) | The ID of the RocketMQ instance |
| <a name="output_rocketmq_instance_name"></a> [rocketmq\_instance\_name](#output\_rocketmq\_instance\_name) | The name of the RocketMQ instance |
| <a name="output_rocketmq_instance_status"></a> [rocketmq\_instance\_status](#output\_rocketmq\_instance\_status) | The status of the RocketMQ instance |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#output\_vswitch\_cidr\_block) | The CIDR block of the VSwitch |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)