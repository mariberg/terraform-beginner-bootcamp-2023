# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials and don't want to commit to your repo
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

If you have a lot of variables, it might be more convenient to list them in a separate file, rather than typing them with the command. The file has to be named as either ``.tfvars`` or ``.tfvars.json``

This is how to refer to the file when running the command:

```
terraform apply -var-file="testing.tfvars"
```

### terraform.tvfars

This is the default file to load in terraform variables in blunk as described above.

### auto.tfvars

Any files with names ending in ``.auto.tfvars`` or ``auto.tfvars.json`` are automatically loaded as variable definitions. 

### order of terraform variables

If the same variable is assigned multiple values, the last value will override any previous value. The variables are loaded in the following order and if several of these options are used, the last will override the previous ones:
 
- environment variables
- ``terraform.tfvars`` if present
- ``terraform.tfvars.json`` if present
-  any ``.auto.tfvars`` or ``.auto.tfvars.json`` files, processed in lexical order of their filenames
- any ``-var`` and ``-var-file`` options on the command line
