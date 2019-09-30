# rasa 入口

setup.py

```
setup(
    name="rasa",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        # supported python versions
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.5",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Topic :: Software Development :: Libraries",
    ],
    packages=find_packages(exclude=["tests", "tools", "docs", "contrib"]),
    # 入口点是“console_script”，它指向命令行工具提供给安装程序包的任何人的函数。
    entry_points={"console_scripts": ["rasa=rasa.__main__:main"]},
```

__main__.py

```
def main() -> None:
    # Running as standalone python application
    parse_last_positional_argument_as_model_path()
    arg_parser = create_argument_parser()
    cmdline_arguments = arg_parser.parse_args()

    log_level = (
        cmdline_arguments.loglevel if hasattr(cmdline_arguments, "loglevel") else None
    )
    set_log_level(log_level)

    if hasattr(cmdline_arguments, "func"):
        rasa.utils.io.configure_colored_logging(log_level)
        cmdline_arguments.func(cmdline_arguments)
    elif hasattr(cmdline_arguments, "version"):
        print_version()
    else:
        # user has not provided a subcommand, let's print the help
        logger.error("No command specified.")
        arg_parser.print_help()
        exit(1)


if __name__ == "__main__":
    main()
```



# rasa cmdline

1. rasa shell

```
def shell(args: argparse.Namespace):
    from rasa.cli.utils import get_validated_path
    from rasa.constants import DEFAULT_MODELS_PATH
    from rasa.model import get_model, get_model_subdirectories

    args.connector = "cmdline"

    model = get_validated_path(args.model, "model", DEFAULT_MODELS_PATH)
    model_path = get_model(model)
    if not model_path:
        print_error(
            "No model found. Train a model before running the "
            "server using `rasa train`."
        )
        return

    core_model, nlu_model = get_model_subdirectories(model_path)

    if not os.path.exists(core_model):
        import rasa.nlu.run

        rasa.nlu.run.run_cmdline(nlu_model)
    else:
        import rasa.cli.run

        rasa.cli.run.run(args)  ##运行bot
```

**执行run.py中run()**

```
def run(args: argparse.Namespace):
    import rasa.run

    args.model = get_validated_path(args.model, "model", DEFAULT_MODELS_PATH)
    args.endpoints = get_validated_path(
        args.endpoints, "endpoints", DEFAULT_ENDPOINTS_PATH, True
    )
    
    #/etc/rasa/credentials.yml证书文件中包含各channel的认证信息
    args.credentials = get_validated_path(
        args.credentials, "credentials", DEFAULT_CREDENTIALS_PATH, True
    )

    rasa.run(**vars(args))
```



rasa docker

```
docker run -v $(pwd):/app rasa/rasa init --no-prompt

docker run -it -v $(pwd):/app rasa/rasa shell


```

