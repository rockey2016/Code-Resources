# Docker容器部署

1. 安装docker容器

   https://docs.docker.com/docker-for-mac/

2. 创建linux VM来运行容器

   ```
   docker-machine create -d virtualbox --virtualbox-disk-size "30000" --virtualbox-cpu-count "1" --virtualbox-memory "1024" docker2kaggle
   
   ```

   在实际使用中我们一般会在物理机上安装 virtualbox 等虚拟机管理软件，并称之为虚拟机 host。然后通过 vSphere 工具安装虚拟机进行使用

   docker-machine命令简介：

   ```
   Create a machine
   
   Description:
      Run 'docker-machine create --driver name' to include the create flags for that driver in the help text.
   
   Options:
      
      --driver, -d "virtualbox"                                                                            Driver to create machine with. [$MACHINE_DRIVER]
      --engine-env [--engine-env option --engine-env option]                                               Specify environment variables to set in the engine
      --engine-insecure-registry [--engine-insecure-registry option --engine-insecure-registry option]     Specify insecure registries to allow with the created engine
      --engine-install-url "https://get.docker.com"                                                        Custom URL to use for engine installation [$MACHINE_DOCKER_INSTALL_URL]
      --engine-label [--engine-label option --engine-label option]                                         Specify labels for the created engine
      --engine-opt [--engine-opt option --engine-opt option]                                               Specify arbitrary flags to include with the created engine in the form flag=value
      --engine-registry-mirror [--engine-registry-mirror option --engine-registry-mirror option]           Specify registry mirrors to use [$ENGINE_REGISTRY_MIRROR]
      --engine-storage-driver                                                                              Specify a storage driver to use with the engine
      --swarm                                                                                              Configure Machine to join a Swarm cluster
      --swarm-addr                                                                                         addr to advertise for Swarm (default: detect and use the machine IP)
      --swarm-discovery                                                                                    Discovery service to use with Swarm
      --swarm-experimental                                                                                 Enable Swarm experimental features
      --swarm-host "tcp://0.0.0.0:3376"                                                                    ip/socket to listen on for Swarm master
      --swarm-image "swarm:latest"                                                                         Specify Docker image to use for Swarm [$MACHINE_SWARM_IMAGE]
      --swarm-join-opt [--swarm-join-opt option --swarm-join-opt option]                                   Define arbitrary flags for Swarm join
      --swarm-master                                                                                       Configure Machine to be a Swarm master
      --swarm-opt [--swarm-opt option --swarm-opt option]                                                  Define arbitrary flags for Swarm master
      --swarm-strategy "spread"                                                                            Define a default scheduling strategy for Swarm
      --tls-san [--tls-san option --tls-san option]                                                        Support extra SANs for TLS certs
      --virtualbox-boot2docker-url                                                                         The URL of the boot2docker image. Defaults to the latest available version [$VIRTUALBOX_BOOT2DOCKER_URL]
      --virtualbox-cpu-count "1"                                                                           number of CPUs for the machine (-1 to use the number of CPUs available) [$VIRTUALBOX_CPU_COUNT]
      --virtualbox-disk-size "20000"                                                                       Size of disk for host in MB [$VIRTUALBOX_DISK_SIZE]
      --virtualbox-host-dns-resolver                                                                       Use the host DNS resolver [$VIRTUALBOX_HOST_DNS_RESOLVER]
      --virtualbox-hostonly-cidr "192.168.99.1/24"                                                         Specify the Host Only CIDR [$VIRTUALBOX_HOSTONLY_CIDR]
      --virtualbox-hostonly-nicpromisc "deny"                                                              Specify the Host Only Network Adapter Promiscuous Mode [$VIRTUALBOX_HOSTONLY_NIC_PROMISC]
      --virtualbox-hostonly-nictype "82540EM"                                                              Specify the Host Only Network Adapter Type [$VIRTUALBOX_HOSTONLY_NIC_TYPE]
      --virtualbox-hostonly-no-dhcp                                                                        Disable the Host Only DHCP Server [$VIRTUALBOX_HOSTONLY_NO_DHCP]
      --virtualbox-import-boot2docker-vm                                                                   The name of a Boot2Docker VM to import [$VIRTUALBOX_BOOT2DOCKER_IMPORT_VM]
      --virtualbox-memory "1024"                                                                           Size of memory for host in MB [$VIRTUALBOX_MEMORY_SIZE]
      --virtualbox-nat-nictype "82540EM"                                                                   Specify the Network Adapter Type [$VIRTUALBOX_NAT_NICTYPE]
      --virtualbox-no-dns-proxy                                                                            Disable proxying all DNS requests to the host [$VIRTUALBOX_NO_DNS_PROXY]
      --virtualbox-no-share                                                                                Disable the mount of your home directory [$VIRTUALBOX_NO_SHARE]
      --virtualbox-no-vtx-check                                                                            Disable checking for the availability of hardware virtualization before the vm is started [$VIRTUALBOX_NO_VTX_CHECK]
      --virtualbox-share-folder                                                                            Mount the specified directory instead of the default home location. Format: dir:name [$VIRTUALBOX_SHARE_FOLDER]
      --virtualbox-ui-type "headless"                                                                      Specify the UI Type: (gui|sdl|headless|separate) [$VIRTUALBOX_UI_TYPE]
   ```

3. 

4. 




```


```





