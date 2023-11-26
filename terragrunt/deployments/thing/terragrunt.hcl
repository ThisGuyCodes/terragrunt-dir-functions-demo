include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
}


locals {
  z_common_read               = read_terragrunt_config(find_in_parent_folders("common.hcl")).locals
  z_common_include            = include.common.locals
  get_original_terragrunt_dir = get_original_terragrunt_dir()
  get_parent_terragrunt_dir   = get_parent_terragrunt_dir("common")
  get_path_from_repo_root     = get_path_from_repo_root()
  get_path_to_repo_root       = get_path_to_repo_root()
  get_terragrunt_dir          = get_terragrunt_dir()
  path_relative_from_include  = path_relative_from_include("common")
  path_relative_to_include    = path_relative_to_include("common")
}
