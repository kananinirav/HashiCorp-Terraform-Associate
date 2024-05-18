# Providers in Terraform

- [Providers in Terraform](#providers-in-terraform)
  - [Providers Introduction](#providers-introduction)
  - [Type Of Providers](#type-of-providers)
    - [Official Providers](#official-providers)
    - [Verified Partner Providers](#verified-partner-providers)
    - [Community Providers](#community-providers)
  - [Use Providers Efficiently](#use-providers-efficiently)
    - [Declaration And Configuration](#declaration-and-configuration)
    - [Version Management](#version-management)
  - [Use Multiple Providers](#use-multiple-providers)
  - [Example](#example)
  - [Best Practices](#best-practices)

## Providers Introduction

- Providers are plugins that allow you to interact with various infrastructure and service providers, enabling ypu to manage resources across different platforms.
- Providers abstract the API interactions and resource lifecycle of cloud platforms, allowing you to define infrastructure as code without worrying about the underlying implementation details.
- Terraform relies on Providers to allow Terraform to interact with remote systems (CSPs, SaaSs, APIs, and so on)

## [Type Of Providers](https://registry.terraform.io/search/providers)

### Official Providers

- Developed and maintained by HashiCorp, the company behind Terraform.
- HashiCorp provides official documentation, support channels, and updates for these providers.
- **Examples**: Providers for major cloud platforms like AWS, Azure, Google Cloud, etc..

### Verified Partner Providers

- Developed and maintained by third-party organizations but have been verified by HashiCorp for quality and compatibility.
- They meet HashiCorp's standards for functionality, reliability, and compatibility with Terraform.
- While not directly supported by HashiCorp, they may have official documentation and support channels provided by their respective organizations.
- Examples: Providers for popular services like GitHub, Datadog, Grafana, etc..

### Community Providers

- Developed and maintained by the Terraform community, consisting of individual contributors, organizations, or third-party vendors.
- Extend Terraform's capabilities to interact with a wide range of services and platforms beyond those officially supported.
- Typically open-source projects hosted on platforms like GitHub, GitLab, etc..

## Use Providers Efficiently

### Declaration And Configuration

- Declare required providers in the root module's `required_providers` block. (see [Requiring Providers](https://developer.hashicorp.com/terraform/language/providers/requirements) for more details)
- Child modules inherit provider configurations from the root module.
- Some providers may require additional configuration information (e.g., endpoints, regions)
- Use the alias meta-argument to define multiple configs for the same provider (that is, to support multiple regions for a cloud platform)

### Version Management

- Specify provider version constraints in `required_providers` to maintain consistent environments.
- Terraform manages version dependencies through the `.terraform.lock.hcl` file. ([dependency lock file](https://developer.hashicorp.com/terraform/language/files/dependency-lock))
- Updates when you run the `terraform init` command
- If provider is in the lock file, Terraform will always use that version unless you run `terraform init -upgrade`
- Include lock file in version control repositories for reproducibility and consistency.

## Use Multiple Providers

There are also two `meta-arguments` that are defined by Terraform itself and available for all provider blocks:

- **alias**, for using the same provider with different configurations for different resources
- **version**, which Terraform doesn't recommend using (use provider requirements instead)

You can configure multiple provider blocks for different AWS regions or accounts within the same Terraform configuration.

```terraform
# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  region = "us-east-1"
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
```

Use that alternate provider, you can select it as a reference:

```terraform
resource "aws_instance" "foo" {
  provider = aws.west

  # ...
}
```

## Example

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  # Configuration options
}
```

According to best practices better to manage providers in separate file.

```terraform
# providers.tf

required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 3.0"
  }

  google = {
    source = "hashicorp/google"
    version = "5.29.1"
  }
}
```

## Best Practices

- **Use Version Constraints**
  - Specify version constraints for provider plugins to ensure compatibility and stability.
  - Use the `version` attribute in the `required_providers` block.
- **Provider Configuration in Module Root**
  - If you're creating Terraform modules, define the provider configuration in the module root rather than within resources.
  - This promotes reusability and consistency.
- **Separate Provider Configuration from Resource Configuration**
  - Keep provider configuration separate from resource definitions for clarity and maintainability.
  - This makes it easier to understand and manage your Terraform code.
- **Use Aliases for Multiple Providers**
  - When working with multiple environments or regions, use provider aliases to differentiate configurations.
  - This prevents resource conflicts and ensures accurate deployment.
- **Centralize Provider Configurations**
  - If you have multiple Terraform configurations across projects or teams, consider centralizing provider configurations in a shared module.
  - This promotes consistency and avoids duplication of code.
- **Secure Credentials**
  - Follow security best practices when managing credentials.
  - Avoid hardcoding sensitive information in Terraform configurations
