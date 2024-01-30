variable "dbname" {
  description = "Database name"
  default	  = "control"
}

variable "dbrootpwd" {
  description = "DB Root password"
  default	  = "rootpwd"
}

variable "dbuser" {
  description = "DB User"
  default	  = "control"
}

variable "dbuserpwd" {
  description = "DB User password"
  default	  = "userpwd"
}

variable "location" {
  description = "The location/region where the core network will be created."
  default     = "fra1"
}