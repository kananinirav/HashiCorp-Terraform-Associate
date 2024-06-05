# Resources & Data Sources

- [Resources \& Data Sources](#resources--data-sources)
  - [Introduction](#introduction)
  - [Resources in Terraform](#resources-in-terraform)
    - [Defining Resources in Terraform](#defining-resources-in-terraform)
    - [Creating Dependent Resources](#creating-dependent-resources)
  - [Data Sources in Terraform](#data-sources-in-terraform)
  - [Example](#example)
    - [Summery](#summery)

## Introduction

- Terraform uses providers to manage resources.
- Resources have specific names defined by the provider.
- Understanding resource names and parameters is crucial for resource creation.

## Resources in Terraform

- **Syntax for Resource Creation:**
  - General format: `resource "<provider>_<resource_name>" "<resource_label>" { ... }`
  - Example: `resource "aws_vpc" "dev_vpc" { ... }`

- **Resource Naming:**
  - Convention: `<provider>_<resource_name>`
  - Example for AWS VPC: `aws_vpc`

- **Resource Parameters:**
  - Each resource block includes parameters like `cidr_block` for `aws_vpc`.
  - Example:

    ```hcl
    resource "aws_vpc" "dev-vpc" {
      cidr_block = "10.0.0.0/16"

      tags = {
        "Name" = "terraform-demo"
      }
    }
    ```

### Defining Resources in Terraform

- Resources must be labeled uniquely within a Terraform configuration.
- Parameters define attributes such as IP ranges for VPCs.
- Example of defining a VPC with CIDR block:

    ```hcl
    resource "aws_vpc" "dev-vpc" {
      cidr_block = "10.0.0.0/16"

      tags = {
        "Name" = "terraform-demo"
      }
    }
    ```

### Creating Dependent Resources

- Resources can reference other resources using interpolation syntax.
- Example: Creating a subnet within a VPC:

  ```hcl
  resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-1a"

    tags = {
      "Name" = "terraform-demo"
    }
  }
  ```

## Data Sources in Terraform

- Data sources allow fetching data defined outside Terraform or by another configuration.

- **Syntax for Data Sources:**

  - General format: `data "<provider>_<data_source_name>" "<data_label>" { ... }`
  - Example:

    ```hcl
    data "aws_vpc" "selected" {
      filter {
        name   = "tag:Name"
        values = ["main"]
      }
    }
    output "vpc_id" {
      value = data.aws_vpc.selected.id
    }
    ```

- **Querying Existing Resources:**

  - Data sources help query existing resources.
  - Example: Fetching default VPC:

    ```hcl
    data "aws_vpc" "existing-vpc" {
      default = true
    }
    ```

## Example

- Creating a VPC and a Subnet:

  ```hcl
    provider "aws" {
      region = "ap-northeast-1"
    }

    resource "aws_vpc" "dev-vpc" {
      cidr_block = "10.0.0.0/16"

      tags = {
        "Name" = "terraform-demo"
        "terraform" = true
      }
    }

    resource "aws_subnet" "dev-subnet-1" {
      vpc_id = aws_vpc.dev-vpc.id
      cidr_block = "10.0.10.0/24"
      availability_zone = "ap-northeast-1a"

      tags = {
        "Name" = "terraform-demo"
        "terraform" = true
      }
    }

  ```

- Fetching an Existing VPC and Create New Subnet

    ```hcl
      provider "aws" {
        region = "ap-northeast-1"
      }

      data "aws_vpc" "existing-vpc" {
        default = true
      }

      resource "aws_subnet" "existing-vpc-new-subnet" {
        vpc_id = data.aws_vpc.existing-vpc.id
        cidr_block = "172.31.48.0/20"
        availability_zone = "ap-northeast-1a"

        tags = {
          "Name" = "existing-vpc-new-subnet"
          "terraform" = true
        }
      }
    ```

### Summery

- **Resources:**
  - Defined using `resource "<provider>_<resource_name>" "<resource_label>" { ... }`
  - Example: `resource "aws_vpc" "main" { ... }`
  - Naming convention: `<provider>_<resource_name>` (e.g., `aws_vpc`)
  - Include necessary parameters like `cidr_block` for `aws_vpc`.
- **Data Sources:**
  - Defined using `data "<provider>_<data_source_name>" "<data_label>" { ... }`
  - Example: `data "aws_vpc" "default" { ... }`
  - Used to fetch data about existing resources.
- **Interpolation and Dependencies:**
  - Reference resources using `${resource_type.resource_name.attribute}`
  - Example: `vpc_id = aws_vpc.main.id`
  - Use data sources to fetch existing resource details (e.g., default VPC ID).
