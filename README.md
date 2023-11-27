# Terragrunt built-in functions demo

## Background

[Terragrunt](https://terragrunt.gruntwork.io/) has various [built-in functions](https://terragrunt.gruntwork.io/docs/reference/built-in-functions), which in particular (as is relevant for this repo) allow you to locate files or construct paths based on the location(s) of the various config files used to compose your final config.

A Terragrunt config can be composed out of:
- The 'entrypoint' config (aka in the docs as the 'original', and in relation to 'parent' configs is also called the 'child')
- Any number of `include`-ed Terragrunt configs (aka the 'parent' configs)
- Any number of additional `read` Terragrunt configs (which themselves may `include` or `read` configs, etc.)

The following functions are [defined in the Terragrunt docs](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/), but I find the wording a little inconsistent and confusing (original vs child, include vs parent, etc), and some things were left ambiguous. At the root of it I wanted to know if the function call exists in one file, how will it answer based on its relationship to the entrypoint.

The functions I was looking to clarify are:
- `get_original_terragrunt_dir()`
- `get_parent_terragrunt_dir()`
- `get_path_from_repo_root()`
- `get_path_to_repo_root()`
- `get_terragrunt_dir()`
- `path_relative_from_include()`
- `path_relative_to_include()`

## Concepts
- The 'entrypoint' is the config file Terragrunt was ran against
- A 'parent' config is one that is `include`-ed from a 'child' config
  - reminder: `include`s can only go 1-deep
- The 'original' config is the one Terragrunt was run against
- Reading a config rather than `include`ing it (via `read_terragrunt_config()`) creates a new 'context' (my word)
- A new context resets parent vs child (the read config considers itself a child, and can `include` parent configs)

## Functions

### [`get_original_terragrunt_dir()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_original_terragrunt_dir)
Always returns the directory of the 'entrypoint' config file. Has the same value during a run no matter which file it's called from.

### [`get_parent_terragrunt_dir()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_parent_terragrunt_dir)
Returns the directory of the 'parent' config relative to this one.

Edge cases:
- If there is no parent, then the current file is considered the parent for the purpose of this function
- If this file *is* the parent, then returns this file's directory
- If this file has multiple parents (multiple `include`s), requires a string argument of the name of the parent to consider (e.g. `include "root" {}` would use `get_parent_terragrunt_dir("root")`)
  - Parent configs don't need to worry about this

### [`get_path_from_repo_root()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_path_from_repo_root)
Returns the relative path to get from the repo root to the directory of the child config of the current context.

### [`get_path_to_repo_root()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_path_to_repo_root)
Returns the relative path to get from the directory of the child config of the current context to the repo root (e.g. a chain of `../..`).

### [`get_terragrunt_dir()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#get_terragrunt_dir)
Returns the full path of the directory of the child config of the current context.

### [`path_relative_from_include()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#path_relative_from_include)
Returns the relative path to get from the directory of the parent config, to the directory of the child config.

Edge cases:
- If there is no parent, then the current file is considered the parent for the purpose of this function (always `.`)
- If this file has multiple parents (multiple `include`s), requires a string argument of the name of the parent to consider (e.g. `include "root" {}` would use `get_parent_terragrunt_dir("root")`)
  - Parent configs don't need to worry about this

### [`path_relative_to_include()`](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#path_relative_to_include)
Returns the relative path to get from the directory of the child config, to the directory of the parent config.

Edge cases:
- If there is no parent, then the current file is considered the parent for the purpose of this function (always `.`)
- If this file has multiple parents (multiple `include`s), requires a string argument of the name of the parent to consider (e.g. `include "root" {}` would use `get_parent_terragrunt_dir("root")`)
  - Parent configs don't need to worry about this
