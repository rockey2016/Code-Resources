# RESTFUL





# CURL

在Linux中curl是一个利用URL规则在命令行下工作的文件传输工具，可以说是一款很强大的http命令行工具。它支持文件的上传和下载，是综合传输工具，但按传统，习惯称url为下载工具。



## 命令

```
star@star-128:~$ curl http://localhost:61208/api/3/pluginslist
["load", "help", "ip", "memswap", "processlist", "cloud", "uptime", "network", "percpu", "irq", "system", "quicklook", "diskio", "gpu", "smart", "folders", "core", "fs", "raid", "mem", "alert", "psutilversion", "sensors", "now", "docker", "wifi", "ports", "processcount", "amps", "batpercent", "cpu"](ShangHai)
```





# HTTPIE



# GLANCES

## 输出

glances --export csv -t 5 --export-csv-file glances-5s.csv



## 过滤

### 命令

glances -f "cmdline:\/usr\/bin\/python.*"



输出日志

```
LOG_CFG=/home/star/.config/glances/glances.json  glances -C ~/.config/glances/glances.conf --export restful
```



参考

[restful]

https://www.runoob.com/w3cnote/restful-architecture.html

https://www.cnblogs.com/artech/p/restful-web-api-02.html

[curl]

https://www.jianshu.com/p/916d56f0d849