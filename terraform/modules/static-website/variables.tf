variable "files" {
  description = "A list of files to turn into Azure storage objects for a static website."
  type        = list(string)
}

variable "name" {
  description = "Name to use for static website resources"
  type        = string
}