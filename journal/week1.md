
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

## Dealing With Configuration Drift

On week 1 we purposely lost our statefile to see how we would deal with such a situation.

## What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform import but it won't work for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

``Terraform import`` is a command that allows you to import existing resources into
your terraform configuration. This command will create a new state file with the existing resources.

We created a a statefile with our exisiting S3 bukcet by running `terraform import aws_s3_bucket.bucket bucket-name`.

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

This can happen if someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan, it will attempt to put our infrastructure back into the expected state fixing Configuration Drift


## Fix using Terraform Refresh

This command is used if your resources have changed and you want them to change locally.
It only updates the state; it doesn't make any changes to the infrastructure itself. It is a read-only operation.

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

Please note these variables have to be defined on top level as well for Terraform to be aware of them.

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

We have created one module 'terrahouse_aws', which we import to main.tf like this:

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```


[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. This often affects providers.



## Working with Files in Terraform

Terraform is used to manage infrastrucure, so it is not usually the best tool for uploading files, even though it can be used for it. In this project we upload the html file using Terraform, however this is not the approach you should usually take in production environment.


### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

Terraform has several built in functions and this is one of them.

filemd5 is a variant of md5 that hashes the contents of a given file rather than a literal string.
It turns the contents of the file into an etag.

Every time the content changes, the etag will change. 

https://developer.hashicorp.com/terraform/language/functions/filemd5



### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}