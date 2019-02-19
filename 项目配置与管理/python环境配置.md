本机为80网段，需要路由到60网段
sudo route add -net 60.60.60.0 netmask 255.255.255.0 gw 80.80.80.254



# VSCODE

## VSCode配置

launch.json中有很多属性可以设置, 通过智能提示查看有那些属性可以设置, 如果要查看属性的具体含义, 可以把鼠标悬停在属性上面, 会属性的使用说明.

在launch.json中会使用到一些预定变量, 这些变量的具体含义如下

${workspaceRoot} the path of the folder opened in VS Code(VSCode中打开文件夹的路径)
${workspaceRootFolderName} the name of the folder opened in VS Code without any solidus (/)(VSCode中打开文件夹的路径, 但不包含"/")
${file} the current opened file(当前打开的文件)
${relativeFile} the current opened file relative to workspaceRoot(当前打开的文件,相对于workspaceRoot)
${fileBasename} the current opened file's basename(当前打开文件的文件名, 不含扩展名)
${fileDirname} the current opened file's dirname(当前打开文件的目录名)
${fileExtname} the current opened file's extension(当前打开文件的扩展名)
${cwd} the task runner's current working directory on startup()

配置终端使用环境：

​    // 配置终端打开的虚拟环境

​    "terminal.integrated.shell.windows": "C:\\Windows\\SysWOW64\\cmd.exe",

​    "terminal.integrated.shellArgs.windows": ["/k","D:\\Manshy\\Anaconda3\\envs\\health\\Scripts\\activate.bat"],

##  VSCode插件

https://www.oschina.net/translate/top-visual-studio-code-extensions



## 配置文件

**说明：launch.json中是是系统中对本项目的默认配置，如果要单独对本项目进行配置，可以用Ctrl+p打开用户设置按下图进行操作，并可以修改，相关的属性值。**



VS Code提供了两种设置方式： 
- 用户设置： 这种方式进行的设置，会应用于该用户打开的所有工程； 
- 工作空间设置：工作空间是指使用VS Code打开的某个文件夹，在该文件夹下会创建一个名为.vscode的隐藏文件夹，里面包含着**仅适用于当前目录的**VS Code的设置。工作空间的设置会覆盖用户的设置。



更改默认用户设置与工作空间设置
VS Code的设置文件为setting.json。

用户设置的文件保存在如下目录： 
- Window %APPDATA%\Code\User\settings.json 
- Mac $HOME/Library/Application Support/Code/User/settings.json 
- Linux $HOME/.config/Code/User/settings.json

工作空间设置的文件保存在当前目录的.vscode文件夹下。



代码静态检查工具：pylint
默认设置
在vscode中依次点击 文件 -> 首选项 -> 设置 打开设置文件 settings.json（编辑器标签标题显示 User Settings ），vscode会自动分左右两栏显示，其中左栏是 默认用户设置 （已锁定为只读） ，右栏是 用户设置 ，用户写在右栏的自定义设置会覆盖掉左栏相应的默认设置。

在 settings.json 页面上方搜索栏内输入 python.linting 即可快速定位与Python代码静态检查工具相关的设置内容。激活 Python 插件后，默认设置已包含以下内容：

  // 默认对Python文件进行静态检查
  "python.linting.enabled": true,

  // 默认在Python文件保存时进行静态检查
  "python.linting.lintOnSave": true,

  // 默认使用pylint对Python文件进行静态检查
  "python.linting.pylintEnabled": true,

一般情况下直接采用以上默认设置即可启用pylint。当Python文件保存时，vscode会调用pylint执行静态检查，如检查发现问题则会以错误、警告或信息等形式显示在vscode下方的问题页面，同时在文本编辑器中以波浪线形式标示问题代码。

pylint在面对django框架时表现的有些不足，有人专门开发了pylint的插件pylint-django，pip install pylint-django即可安装，命令行里可以通过 pylint --load-plugins pylint_django [other option]。



==可以通过"pylint --generate-rcfile"生成配置文件模板==，可以在模板文件上定制相关的统一的配置文件。配置文件中包含了master， message control， reports， typecheck， similarities，  basic， variables， format， design， classes， imports， exception相关的lint配置信息，用户可以进行私人订制。

命令：

```
pylint --persistent=y --generate-rcfile > .pylintrc
```



更新

```
 pip install --upgrade pandas==0.23.4
```

## pytest

运行模块中的指定方法

```
pytest test_mod.py::test_func
```



注意：==如果安装了pytest-cov coverage模块，则VS Code在调试时不会在断点处停止==，因为pytest-cov使用相同的技术来访问正在运行的源代码。要防止此行为，请`--no-cov`在`pyTestArgs`调试测试时包括。




代码编排：autopep8

autopep8 --in-place --aggressive --aggressive test_autopep8.py

Autopep8是一个将Python代码自动排版为PEP8风格的小工具。它使用pep8工具来决定代码中的哪部分需要被排版。Autopep8可以修复大部分pep8工具中报告的排版问题。

```
// Place your settings in this file to overwrite the default settings
{
    // "editor.fontFamily": "'DejaVu Sans Mono for Powerline'",
    "editor.fontFamily": "'Fira Code'",
    "editor.fontLigatures": true,
    // Controls the font size.
    "editor.fontSize": 22,
    "editor.renderIndentGuides": true,
    "editor.occurrencesHighlight": false,
    // Columns at which to show vertical rulers
    "editor.rulers": [
        100
    ],
    // Arguments passed in. Each argument is a separate item in the array.
    "python.formatting.autopep8Args": [
        "--max-line-length=100",
        "--indent-size=2"
    ],
    // Format a file on save. A formatter must be available, the file must not be auto-saved, and editor must not be shutting down.
    "editor.formatOnSave": true,
    // Format the document upon saving.
    "python.formatting.formatOnSave": true,
    "python.linting.pylintArgs": [
        "--include-naming-hint=n",
        "--disable=W0311",
        "--disable=C0103",
        "--disable=E1101"
    ],
    "files.trimTrailingWhitespace": true,
    // The number of spaces a tab is equal to. This setting is overriden based on the file contents when `editor.detectIndentation` is on.
    "editor.tabSize": 2,
    "files.exclude": {
        ".vs*": true,
        "*.*~": true,
        "*.pyc": true,
        "*/*.pyc": true
    },
    "files.autoSave": "onWindowChange",
    "git.confirmSync": false,
    "window.zoomLevel": 0,
    "editor.minimap.enabled": true,
    "editor.minimap.maxColumn": 120,
    "workbench.welcome.enabled": false,
    "workbench.colorTheme": "Monokai",
    "workbench.iconTheme": "vs-nomo-dark"
}
```

使用

https://www.jianshu.com/p/46df032e9ade





# Jupyter插件

 ## **安装Jupyter NbExtensions Conf igurator**

```
conda install -c conda-forge jupyter_contrib_nbextensions
conda install -c conda-forge jupyter_nbextensions_configurator
```

`pip install jupyter_contrib_nbextensions`

`jupyter contrib nbextension install --user`

`pip install jupyter_nbextensions_configurator`

 `jupyter nbextensions_configurator enable --user` 

插件：

然后打开jupyter notebook勾选相应插件即可：

1.  **Collapsible headings**
    放下/收起notebook的某些内容
2.  **Notify**
    Notify功能就能在任务处理完后及时向你发送通知
3.  **Codefolding**
    折叠代码
4.  **tqdm_notebook**
    显示进度条
5.  **%debug**
    调试代码，直接跳到错误的地方
6.  **Table of Contents**
    自动生成目录

## magics list

- `$$ $$`
   用LaTex写公式，`$$ P(A \mid B) = \frac{P(B \mid A) , P(A)}{P(B)} $$`
- `%%bash`,`%%HTML`,`%%python2`,`%%ruby`
   指定解释器
- `%load`
   `%load ./printName.py`载入外部脚本
- `%env`
   设置环境变量
- `%%writefile`
   可以保存cell下面内容到文件
- `%pycat`
   弹窗打开文件
- `%pdb`
   调试程序
   -`%prun`
   每个函数消耗的时间
- `%%time`
   cell内代码的单次运行时间信息
- `%who`
   列出所有的全局变量

## 快捷键

`Esc + F` 在代码中查找、替换
`Esc + O` 在cell和输出结果间切换。
`Shift + J` 或 `Shift + Down` 选择下一个cell。
`Shift + K` 或 `Shift + Up` 选择上一个cell。
`Shift + M` 合并cell



##  制作slides





## 转换PDF

1.下载MiKTeX并安装

https://miktex.org/download

2.编译jupyter文件tex

```
jupyter nbconvert --to latex 机器学习医疗诊断.ipynb
```

3.手动编辑latex文件

为了能支持输出中文，需要改一下tex文件，在编辑器（我用的是Notepad++）打开刚才生成的LaTeX文件，
在**\documentclass{article}**（或\documentclass[11pt]{ctexart} ）的后面插入

```
\usepackage{fontspec, xunicode, xltxtra}
\setmainfont{Microsoft YaHei}
```

4.转pdf

```
xelatex 机器学习医疗诊断.tex
```





#  离线搭建环境

yum install gcc make zlib-devel

PATH=$PATH:/opt/python3/bin

编译python:

./configure  --prefix=/opt/python3

make

make install 



mv /usr/bin/python /usr/bin/python2.6

ln -s /usr/local/python/bin/python3.6 /usr/bin/python

在线安装：

pip install numpy -d /root/pythonenv/
pip install pandas -d /root/pythonenv/
pip install  sklearn -d /root/pythonenv/
pip install pickle -d /root/pythonenv/
pip install keras -d /root/pythonenv/
pip install tensorflow -d /root/pythonenv/
pip install matplotlib -d /root/pythonenv/
pip install lightgbm -d /root/pythonenv/
pip install psycopg2 -d /root/pythonenv/

  pip list
  pip freeze >requirements.txt

根据本地目录安装

pip install --no-index -f /root/pythonenv/ -r requirements.txt

 



搭建本地pip源：

https://www.cndba.cn/dave/article/2263	

 

#  python开发环境搭建

##  conda与virtualenv

`pip`+ virtualenv = conda

`pip`是一个包管理器，`virtualenv`是一个环境管理器，而`conda`就是它们俩的综合体。

**注意：请不要使用PowerShell去执行virtualenv命令，换成cmd去执行才可以。**

### virtualenv



## conda

Conda是一个通用的包管理器，当初设计来管理任何语言的包。

###  配置：

```
文件名：#在系统当前用户目录下
.condarc
内容：
channels:
  - conda-canary
  - https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
  - https://repo.anaconda.com/pkgs/r/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
  - intel
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - defaults
ssl_verify: true
show_channel_urls: true

```

### 创建

```
conda create --name clustering python=3.7.2
```

![1547721809664](D:\Code-Resources\项目配置与管理\assets\1547721809664.png)



```
#将虚拟环境添加到Jupyter notebook 的内核中
pip install ipykernel
python -m ipykernel install --user --name cluster --display-name "clustering"
```





### 更新

conda update conda

conda update --all 
这个命令更新当前环境中所有包到最新版本。

conda update -n health --all 
这个命令更新环境env中所有的包到最新版本

conda update package_name 
该命令只更新特定的包package_name。

```
python3 -m pip install --upgrade pandas
```



# docker

```
ssh root@60.60.60.70
docker exec -it dsmart/ml_dsmart_cluster /bin/bash
pip uninstall dsmart_clustering
pip install --no-cache-dir -i http://80.80.80.229:3141/ dsmart_clustering --trusted-host 80.80.80.229

```

