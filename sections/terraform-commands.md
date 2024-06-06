# Terraform Commands with Details

| Command                           | Description                                                                                                            | Example                                          |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `terraform init`                  | Initializes a Terraform configuration. Downloads necessary provider plugins and sets up the backend for state storage. | `terraform init`                                 |
| `terraform init -upgrade`         | Upgrades all provider plugins to the latest version.                                                                   | `terraform init -upgrade`                        |
| `terraform plan`                  | Creates an execution plan, showing what actions Terraform will take to achieve the desired state.                      | `terraform plan`                                 |
| `terraform plan -out=path`        | Saves the generated execution plan to a file. Useful for review before applying.                                       | `terraform plan -out=tfplan`                     |
| `terraform plan -destroy`         | Generates a plan to destroy all resources managed by the configuration.                                                | `terraform plan -destroy`                        |
| `terraform apply`                 | Applies the changes required to reach the desired state of the configuration.                                          | `terraform apply`                                |
| `terraform apply -auto-approve`   | Applies the changes without asking for user confirmation.                                                              | `terraform apply -auto-approve`                  |
| `terraform apply -refresh=true`   | Ensures Terraform refreshes its state before applying the changes.                                                     | `terraform apply -refresh=true`                  |
| `terraform apply -input=false`    | Ask for input for variables if not directly set.                                                                       | `terraform apply -input=false`                   |
| `terraform apply -var 'foo=bar'`  | Sets a variable directly from the command line.                                                                        | `terraform apply -var 'environment=production'`  |
| `terraform apply -var-file=foo`   | Loads variables from a file.                                                                                           | `terraform apply -var-file=production.tfvars`    |
| `terraform apply -target`         | Applies/Destroys changes only to the specified resource.                                                               | `terraform apply -target=aws_instance.example`   |
| `terraform destroy -auto-approve` | Destroys all resources managed by the configuration without asking for user confirmation.                              | `terraform destroy -auto-approve`                |
| `terraform destroy -target`       | Destroys only the specified resource.                                                                                  | `terraform destroy -target=aws_instance.example` |
