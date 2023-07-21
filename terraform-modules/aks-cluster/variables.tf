variable "location" {
  description = "Azure region to create resources in. EG. \"UK South\"."
  type        = string
}

variable "name" {
  description = "Name used for AKS resources."
  type = string
}

variable "tags" {
  description = "A map of tags supplied to the module"
  type = map(any)
}