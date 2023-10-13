# Terraform Beginner Bootcamp 2023 - Week 2

- [Working with Ruby](#working-with-ruby)
  - [Bundler](#bundler)
    - [Install Gems](#install-gems)
    - [Executing Ruby Scripts in the Context of Bundler](#executing-ruby-scripts-in-the-context-of-bundler)
  - [Sinatra](#sinatra)
- [Terratowns Mock Server](#terratowns-mock-server)
  - [Running the Web Server](#running-the-web-server)
- [CRUD](#crud)

On week 2 it was time to finalize our project and get all the different parts connected to each
other. We already knew from previous week how to manage AWS resources using Terraform. Now it was time to use Terraform on another cloud platform and for that we needed to build our own custom
provider. 

## Working with Ruby

We used Ruby to build our mock server, which was needed to test our custom provider locally.

### Bundler

Bundler is a package manager for Ruby.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future Ruby scripts to use the gems we installed. This is the way we set context.

There is no direct equivalent to this command in Node.js, because dependencies are automatically managed in the `node_modules` folder.

### Sinatra

Sinatra is a micro web-framework for Ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## Working with Go

Our custom provider was built using Go(Golang) as that is commonly used to build Terraform providers. We wrote our code in ``main.go`` and then used a bash script to build the provider.
This is because Go files are compiled into binaries before running.

The code for the custom provider in ``main.go`` had to define all CRUD options as that is indeed
how all Terraform custom providers work.


## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete