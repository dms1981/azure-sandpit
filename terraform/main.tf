module "sandpit" {
  source     = "./modules/vnet"
  cidr_block = "10.0.0.0/16"
  name       = "dms1981"
}

module "static-website" {
  source = "./modules/static-website"
  files  = ["./website/index.html"]
  name   = "hamsters"
}