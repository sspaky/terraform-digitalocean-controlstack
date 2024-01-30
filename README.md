# ControlStack
## This is a terraform module for DigitalOcean to create supporting stack for dedicated control set of servers

## Table of Contents

- [Usage](#usage)
- [Installation](#installation)
- [Generated resources](#generated-resources)

## Usage
```hcl
module "example" {
  source = "github.com/example/module"

  # Module version using SemVer
  version = "0.1.0"

  # Other module configuration settings...
}
```

## Installation
Prepare your do_token and pvt_key to initialize connection to Digital Ocean acount

## Generated resources
1. Redis
2. Nginx
3. MariaDB
