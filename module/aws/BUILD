filegroup(
    name = "modules_src",
    srcs = glob([
        "*.hcl",
        "*.tfvars",
        "**/*.tf",
        "**/*.tfvars",
        "**/*.tmpl",
        "**/*.hcl",
        "**/*.sh",
        "**/*.json",
        "**/*.js",
        "**/*.py",
        "**/*.ipynb",
        "**/*.py.zip",
        "**/*.ini",
        "**/*.tpl",
        "**/*.yaml",
        "**/*.yml",
        "**/*.zip",
        "**/pyodbc-layer/*",
        "**/*.txt",
        "**/*.png",
        "**/*.css",
        "**/*.md",
        "**/*.MD",

    ])
)

filegroup(
    name = "helper_scripts",
    srcs = glob([
        "**/*.sh",
    ])
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/init_module.sh",
    name = "init_module",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/init_all.sh",
    name = "init_all",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/plan_module.sh",
    name = "plan_module",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/plan_all.sh",
    name = "plan_all",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/apply_module.sh",
    name = "apply_module",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/apply_all.sh",
    name = "apply_all",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/destroy_module.sh",
    name = "destroy_module",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/destroy_all.sh",
    name = "destroy_all",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/output_module.sh",
    name = "output_module",
)

sh_binary(
    deps = [
        ":modules_src",
        ":helper_scripts",
    ],
    main = "commands/output_all.sh",
    name = "output_all",
)

genrule(
    cmd = [
        "terraform fmt -check -recursive | tee tf_format_errors.log",
    ],
    deps = [":modules_src"],
    labels = ["lint"],
    name = "tf_fmt",
    outs = ["tf_format_errors.log"],
)

genrule(
    cmd = [
        "terragrunt fmthcl terragrunt hclfmt --terragrunt-check | tee tg_format_errors.log",
    ],
    deps = [":modules_src"],
    labels = ["lint"],
    name = "tg_fmt",
    outs = ["tg_format_errors.log"],
)