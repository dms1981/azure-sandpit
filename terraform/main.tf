module "sandpit" {
  source     = "./modules/vnet"
  cidr_block = "10.0.0.0/16"
  name       = "dms1981"
}