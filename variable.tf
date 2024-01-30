variable "do_token" {
  type		  = "string"
  required	  = "yes"
  description = "Digital Ocean token"
}

variable "dbname" {
  type		  = "string"
  required	  = "no"
  description = "Database name"
  default	  = "control"
}

variable "dbrootpwd" {
  type		  = "string"
  required	  = "no"
  description = "DB Root password"
  default	  = "rootpwd"
}

variable "dbuser" {
  type		  = "string"
  required	  = "no"
  description = "DB User"
  default	  = "control"
}

variable "dbuserpwd" {
  type		  = "string"
  required	  = "no"
  description = "DB User password"
  default	  = "userpwd"
}

variable "location" {
  description = "The location/region where the core network will be created."
  default     = "fra1"
}