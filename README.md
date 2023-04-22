Clone repo:
```shell
git clone https://gitlab.repozytoriumwiedzy.tech/studies/psroz_s102023.git
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
