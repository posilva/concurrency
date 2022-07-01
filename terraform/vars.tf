variable "keyname" {
  type        = string
  description = "Existing Key name to SSH into the instance"
  default     = "pms-testing"
}

variable "source_ip" {
  type        = string
  description = "Allow access from the local workstation"
  default     = "94.61.213.147/32"
}