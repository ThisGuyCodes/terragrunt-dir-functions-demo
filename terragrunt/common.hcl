locals {
  get_original_terragrunt_dir = get_original_terragrunt_dir()
  get_parent_terragrunt_dir   = get_parent_terragrunt_dir()
  get_path_from_repo_root     = get_path_from_repo_root()
  get_path_to_repo_root       = get_path_to_repo_root()
  get_terragrunt_dir          = get_terragrunt_dir()
  path_relative_from_include  = path_relative_from_include()
  path_relative_to_include    = path_relative_to_include()
  z_side                      = read_terragrunt_config("${get_parent_terragrunt_dir()}/side_read.hcl").locals
  z_deep_side                 = read_terragrunt_config("${get_original_terragrunt_dir()}/deep_side.hcl").locals
}
