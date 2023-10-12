# Azure & Terraform computervision website

A website build with Azure cloud using Terraform with a main feature being computer vision 

# Authors

Julian Helwig - https://julian.helwig.tech/#/ https://github.com/Nailu776

Seweryn Kopeć - https://github.com/SewerynKopec

# Description
A website build with Azure resources using Terraform.

A user can login via their Azure account and upload their images.

The images form a gallery and via the functions are sent to the computer vision service.

After a while, the image is automatically described.
# Instructions
Clone repository:
```shell
git clone https://gitlab.hjhp.io/studies/psroz_s102023.git
cd psroz_s102023
```
  
Log in to azure:
```shell
az login
```

Prepare ./terraform/secret.tfvars file with:  
MICROSOFT_PROVIDER_AUTHENTICATION_SECRET = ""

Deploy infra:
```shell
cd terraform
terraform init
terraform plan -var-file="secret.tfvars" -out=terraformplan
terraform apply -auto-approve terraformplan
```

Deploy function apps:
```shell
cd ./FunctionApps/uploadFunApp/PythonFunctionsProject
func azure functionapp publish imgs-fun-app --python
```

```shell
cd ./FunctionApps/Cognitive/CognitiveFunProject
func azure functionapp publish cognitive-fa --python
```

Destroy
```shell
terraform destroy -var-file="secret.tfvars"
```
