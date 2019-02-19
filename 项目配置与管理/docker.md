

使用官方脚本安装：

`curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`

创建docker用户：

sudo usermod -aG docker docker

安装校验：

![1534422209971](D:\Manshy\OpenProject\MachineLearning\docs\assets\1534422209971.png)

配置加速器：

sudo mkdir -p /etc/docker 

sudo tee /etc/docker/daemon.json <<-'EOF' 

{ "registry-mirrors": ["https://2pltq3lu.mirror.aliyuncs.com"] } 

EOF 

sudo systemctl daemon-reload 

sudo systemctl restart docker



# 下拉镜像

从注册服务器`registry.hub.docker.com` 中的 `ubuntu` 仓库来下载标记为 `12.04` 的镜像。

sudo docker pull registry.hub.docker.com/ubuntu:12.04 



有时候官方仓库注册服务器下载较慢，可以从其他仓库下载。 

从其它仓库下载时需要指定完整的仓库注册服务器地址。

例如

```
sudo docker pull dl.dockerpool.com:5000/ubuntu:12.04
```

导出镜像

`sudo docker save -o python.tar python`

载入镜像

```
sudo docker load < python.tar 
```



# 容器

当利用 `docker run` 来创建容器时，Docker 在后台运行的标准操作包括：

- 检查本地是否存在指定的镜像，不存在就从公有仓库下载
- 利用镜像创建并启动一个容器
- 分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
- 从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
- 从地址池配置一个 ip 地址给容器
- 执行用户指定的应用程序
- 执行完毕后容器被终止



`sudo docker run python /bin/echo "hello world"`

hello world



# 数据卷

数据卷是一个可供一个或多个容器使用的特殊目录，它绕过 UFS，可以提供很多有用的特性：

- 数据卷可以在容器之间共享和重用
- 对数据卷的修改会立马生效
- 对数据卷的更新，不会影响镜像
- 卷会一直存在，直到没有容器使用

*数据卷的使用，类似于 Linux 下对目录或文件进行 mount。



Docker问题：

- 不能在宿主机上很方便地访问容器中的文件。
- 无法在多个容器之间共享数据。
- 当容器删除时，容器中产生的数据将丢失。

为了解决这些问题，docker 引入了数据卷(volume) 机制。数据卷是存在于一个或多个容器中的特定文件或文件夹，这个文件或文件夹以独立于 docker 文件系统的形式存在于宿主机中。数据卷的最大特定是：**其生存周期独立于容器的生存周期**。

## # 使用数据卷的最佳场景

- 在多个容器之间共享数据，多个容器可以同时以只读或者读写的方式挂载同一个数据卷，从而共享数据卷中的数据。
- 当宿主机不能保证一定存在某个目录或一些固定路径的文件时，使用数据卷可以规避这种限制带来的问题。
- 当你想把容器中的数据存储在宿主机之外的地方时，比如远程主机上或云存储上。
- 当你需要把容器数据在不同的宿主机之间备份、恢复或迁移时，数据卷是很好的选择。

## # docker volume 子命令

docker 专门提供了 volume 子命令来操作数据卷：
**create**        创建数据卷
**inspect**      显示数据卷的详细信息 
**ls**               列出所有的数据卷
**prune**        删除所有**未使用的 volumes**，并且有 -f 选项
**rm**             删除一个或多个未使用的 volumes，并且有 -f 选项



# Docker File

Dockerfile 分为四部分：基础镜像信息、维护者信息、镜像操作指令和容器启动时执行指令。 

一开始必须指明所基于的镜像名称，接下来推荐说明维护者信息。

后面则是镜像操作指令，例如 `RUN` 指令，`RUN` 指令将对镜像执行跟随的命令。每运行一条 `RUN` 指令，镜像添加新的一层，并提交。

最后是 `CMD` 指令，来指定运行容器时的操作命令。

```
# This dockerfile uses the ubuntu image
# VERSION 2 - EDITION 1
# Author: docker_user
# Command format: Instruction [arguments / command] ..
#image名称：仓库名/作者名/镜像名:TAG
# Base image to use, this must be set as the first line
FROM ubuntu

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER docker_user docker_user@email.com

# Commands to update the image
RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Commands when creating a new container
CMD /usr/sbin/nginx
```

## Dockerfile命令

### From

所有Dockerfile都必须以FROM命令开始。 

FROM命令会指定镜像基于哪个基础镜像创建，接下来的命令也会基于这个基础镜像（CentOS和Ubuntu有些命令可是不一样的）。FROM命令可以多次使用，表示会创建多个镜像。

FROM <image name> 或者：FROM <image>:<tag>

### MAINTAINER

MAINTAINER：用来指定维护者的姓名和联系方式。MAINTAINER <author name>

更改MAINTAINER指令会使Docker强制执行RUN指令来更新apt，而不是使用缓存。

### RUN

RUN：在shell或者exec的环境下执行的命令。

RUN指令会在新创建的镜像上添加新的层面，接下来提交的结果用在Dockerfile的下一条指令中。

每条 RUN 指令将在当前镜像基础上执行指定命令，并提交为新的镜像。当命令较长时可以使用 \ 来换行。也就是说RUN命令会在上面FROM指定的镜像里执行任何命令，然后提交(commit)结果，提交的镜像会在后面继续用到。

 RUN命令等价于:

```
docker run image command
docker commit container_id
```

格式为 RUN <command> 或 RUN  ["executable", "param1", "param2"]。

前者将在shell终端中运行命令，即 /bin/sh -c ；后者则使用 exec 执行。

指定使用其它终端可以通过第二种方式实现，例如 RUN  ["/bin/bash", "-c", "echo hello"] 。

### CMD

**CMD**：提供了容器默认的执行命令。 Dockerfile只允许使用一次CMD指令。多个只有最后一个指令生效。

支持三种格式
 CMD ["executable","param1","param2"] 使用 exec 执行，推荐方式；
 CMD command param1 param2 在 /bin/sh 中执行，提供给需要交互的应用；
 CMD ["param1","param2"] 提供给 ENTRYPOINT 的默认参数；

### ENV

**ENV**：设置环境变量。它们使用键值对，增加运行程序的灵活性。

语法如下：ENV <key> <value>

设置了后，后续的RUN命令都可以使用

### ENTRYPOINT 

**ENTRYPOINT**：配置给容器一个可执行的命令，在每次使用镜像创建容器时一个特定的应用程序可以被设置为默认程序。同时也意味着该镜像每次被调用时仅能运行指定的应用。

类似于CMD，Docker只允许一个ENTRYPOINT，多个ENTRYPOINT会抵消之前所有的指令，只执行最后的ENTRYPOINT指令。



 ENTRYPOINT 命令设置在容器启动时执行命令，也就是配置容器启动后执行的命令，并且不可被 docker run 提供的参数覆盖。

```text
# cat Dockerfile
FROM ubuntu
ENTRYPOINT echo "Welcome!"

# docker run 62fda5e450d5
Welcome!
```

 两种语法格式，一种就是上面的(shell方式):ENTRYPOINT cmd param1 param2 .

### EXPOSE

**EXPOSE**：指定容器在运行时监听的端口。

语法如下：EXPOSE <port> [<port>...]

比如memcached使用端口 11211，可以把这个端口暴露在外，这样容器外可以看到这个端口并与其通信。

**Note**: <port>后面不能接空格或者注释什么的，否则会报错：EXPOSE 22 INFO[1063] Invalid containerPort:

Docker的核心概念是可重复和可移植。镜像应该可以运行在任何主机上并且运行尽可能多的次数。

在Dockerfile中你有能力映射私有和公有端口，但是你永远不要通过Dockerfile映射公有端口。

通过映射公有端口到主机上，你将只能运行一个容器化应用程序实例。（运行多个端口不就冲突啦）
 ＃private and public mapping
 EXPOSE 80:8080
 ＃private only
 EXPOSE 80
 如果镜像的使用者关心容器公有映射了哪个公有端口，他们可以在运行镜像时通过-p参数设置，否则，Docker会自动为容器分配端口。
 切勿在Dockerfile映射公有端口。

### 构建指令：

 docker build -f /root/test/DockerFile -t py-ubuntu:v1.0 /root/test

 docker run -d -p 22 py-ubuntu:v1.0



# docker-machine



curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && chmod +x /tmp/docker-machine && sudo cp /tmp/docker-machine /usr/local/bin/docker-machine



# Docker Compose

Docker Compose是一个用来定义和运行复杂应用的Docker工具。一个使用Docker容器的应用，通常由多个容器组成。使用Docker Compose不再需要使用shell脚本来启动容器。 

一个使用Docker容器的应用，通常由多个容器组成。使用Docker Compose，不再需要使用shell脚本来启动容器。在配置文件中，所有的容器通过

```
services
```

来定义，然后使用

```
docker-compose
```

脚本来启动，停止和重启应用，和应用中的服务以及所有依赖服务的容器。完整的命令列表如下：

> `build` 构建或重建服务
>
> ------
>
> `help` 命令帮助
> `kill` 杀掉容器
> `logs` 显示容器的输出内容
> `port` 打印绑定的开放端口
> `ps` 显示容器
> `pull` 拉取服务镜像
> `restart` 重启服务
> `rm` 删除停止的容器
> `run` 运行一个一次性命令
> `scale` 设置服务的容器数目
> `start` 开启服务
> `stop` 停止服务
> `up` 创建并启动容器

## 安装

```
curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## docker-compose.yml

```
version: "3.0"
services:

  rt_ml_service:
    build: ./
    container_name: rt-mlservice
    tty: true
    restart: always
    network_mode: "host"

    volumes: 
      - <change2 your local data path>:/data
      #- /media/data/health_data:/data
```



# 参考

http://www.cnblogs.com/aiyuxi/p/6310080.html





