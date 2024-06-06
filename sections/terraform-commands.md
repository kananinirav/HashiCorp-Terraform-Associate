# Terraform Commands with Details

| Command                           | Description                                                                                                            |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `terraform init`                  | Initializes a Terraform configuration. Downloads necessary provider plugins and sets up the backend for state storage. |
| `terraform init -upgrade`         | Upgrades all provider plugins to the latest version.                                                                   |
| `terraform plan`                  | Creates an execution plan, showing what actions Terraform will take to achieve the desired state.                      |
| `terraform plan -out=path`        | Saves the generated execution plan to a file. Useful for review before applying.                                       |
| `terraform plan -destroy`         | Generates a plan to destroy all resources managed by the configuration.                                                |
| `terraform apply`                 | Applies the changes required to reach the desired state of the configuration.                                          |
| `terraform apply -auto-approve`   | Applies the changes without asking for user confirmation.                                                              |
| `terraform apply -refresh=true`   | Ensures Terraform refreshes its state before applying the changes.                                                     |
| `terraform apply -input=false`    | Ask for input for variables if not directly set.                                                                       |
| `terraform apply -var 'foo=bar'`  | Sets a variable directly from the command line. </br>`terraform apply -var 'environment=production'`                   |
| `terraform apply -var-file=foo`   | Loads variables from a file.  </br> `terraform apply -var-file=production.tfvars`                                      |
| `terraform apply -target`         | Applies/Destroys changes only to the specified resource.  </br> `terraform apply -target=aws_instance.example`         |
| `terraform destroy -auto-approve` | Destroys all resources managed by the configuration without asking for user confirmation.                              |
| `terraform destroy -target`       | Destroys only the specified resource.   </br> `terraform destroy -target=aws_instance.example`                         |
