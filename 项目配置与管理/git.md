# Git用户与gitHub用户

## git客户端用户名、邮箱的作用

本地的git需要设置用户名和邮箱，其本质是本地git客户端的一个变量，不随git库改变，但也可以为某个库单独设置用户名和邮箱，github或码云等都是根据git客户端的用户名和邮箱来进行contributions统计的，每次commit的记录也是使用git客户端的用户名和邮箱，所以当客户端邮箱、用户名和github邮箱、用户名不一致时，会导致github无法统计contributions，这是由于客户端的用户名、邮箱并不对应真实的github账号，所以无法统计，且提交者头像变灰，因为它是未知github账号，当然你把用户名和邮箱改为别人的实际存在的github的用户名邮箱，那么git push后提交者将变成别人的github账号。

结论：尽量将git客户端的用户名、邮箱和github账号的用户名、邮箱设置为完全一致。

# 配置sshkey

取消全局变量设置

```
$ git config --global --unset user.name
$ git config --global --unset user.email
```

**配置用户**

```
$ git config user.name 'rockey2016'
$ git config user.email 'rockey-star@163.com'
```



# 下拉代码库

`$ git clone git@gitlab.dfc.com:MachineLearning/health_predict.git`
Cloning into 'health_predict'...

<!--克隆完成之后，可以看见一些git相关文件，实际上Git自动clone的是远程的master分支，并且把本地的master分支和远程的master分支对应起来。-->

`$ git branch -a`  <!--查看所有远程分支-->

* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/develop
  remotes/origin/master

`$ git branch develop`  <!--创建远程origin的develop分支到本地--> 

$ `git branch`  <!--查看本地分支develop-->
  develop
* master

`$ git checkout develop`  <!--切换到本地develop分支-->
Switched to branch 'develop'

`$ git pull origin develop`  <!--从远程获取最新版本并merge到本地 ，git pull 相当于git fetch 和 git merge。在实际使用中，git fetch更安全一些，因为在merge前，我们可以查看更新情况，然后再决定是否合并 。-->



**拉取远程分支并创建本地分支，可以直接使用命令：**

`git checkout -b 本地分支名x origin/远程分支名x`

`$ git branch -r`
  origin/HEAD -> origin/master
  origin/gh-pages
  origin/master
  origin/testing_and_release


`$ git checkout -b gh-pages origin/gh-pages`
Switched to a new branch 'gh-pages'
Branch 'gh-pages' set up to track remote branch 'gh-pages' from 'origin'.

# 添加develop分支

`$ git checkout -b develop master`
Switched to a new branch 'develop'


`$ git branch`

* develop
  master

切换到Master分支 

`$ git checkout master`
Switched to branch 'master'
Your branch is up to date with 'origin/master'.

对Develop分支进行合并 ，将develop分支合并到master分支上。

`$ git merge --no-ff develop`
Already up to date.

<!--使用--no-ff参数后，会执行正常合并，在Master分支上生成一个新节点。为了保证版本演进的清晰，我们希望采用这种做法。--> 

`$ git push origin develop`  #将develop分支同步到远程服务器
Counting objects: 6, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 269.47 KiB | 8.69 MiB/s, done.
Total 6 (delta 3), reused 0 (delta 0)
remote:
remote: To create a merge request for develop, visit:
remote:   http://gitlab.dfc.com/MachineLearning/health_predict/merge_requests/new?merge_request%5Bsource_branch%5D=develop
remote:
To gitlab.dfc.com:MachineLearning/health_predict.git

 * [new branch]      develop -> develop

# 版本回退

###  git本地版本回退

`$ git log -oneline`
13b55aa (HEAD -> develop, origin/master, master) 20180717
80400c4 Merge branch 'master' of gitlab.dfc.com:MachineLearning/health_predict not correpondse
0263f7c commit at 20180717
d7905de 格式调整
4fe4fbc Add new file .gitignore
0706784 update at 20180706
adb2f19 20180629
ad538d6 commit update at 20180628
421a3a3 commit by sxx at 20180615
b83396c add readme file
81f0939 first commit at 20180614 by sxx

`$ git reset --hard d7905de`
HEAD is now at d7905de 格式调整

`$ git log --oneline`

d7905de (HEAD -> develop) 格式调整

4fe4fbc Add new file .gitignore
0706784 update at 20180706
adb2f19 20180629
ad538d6 commit update at 20180628
421a3a3 commit by sxx at 20180615
b83396c add readme file
81f0939 first commit at 20180614 by sxx



### git远程版本回退

`git push origin HEAD --force` #远程提交回退 

或者

`git reset --hard HEAD~1`

`git push --force` 



# 添加远程仓库

$ git remote add github git@github.com:rockey2016/Health.git



# 提交代码

将代码提交到另外一个分支

在本分支下git add,git commit,git push

切换分支  git checkout

查看提交点  git log --oneline

复制   git **cherry-pick**  <commitid>



# Git版本规范

## 分支

----------------------------------

==master分支==为主分支(保护分支)，不能直接在master上进行修改代码和提交；
==develop分支==为测试分支，所以开发完成需要提交测试的功能合并到该分支；
==feature分支==为开发分支，大家根据不同需求创建独立的功能分支，开发完成后合并到develop分支；
==fix分支为==bug修复分支，需要根据实际情况对已发布的版本进行漏洞修复；

### develop 分支

develop分支可以用来生成代码的最新代码版本。如果想正式对外发布，就在Master分支上，对Develop分支进行"合并"（merge）。

- develop 为开发分支，始终保持最新完成以及bug修复后的代码
- 一般开发的新功能时，feature分支都是基于develop分支下创建的



## feature 分支

- 开发新功能时，以develop为基础创建feature分支
- 分支命名: feature/ 开头的为特性分支， 命名规则: feature/user_module、 feature/cart_module

**创建分支**

其中对于 Feature 功能分支有；
从哪个分支分离开来：develop
必须要合并到哪个分支上：develop
分支的命名规范：除了 master，develop，release-，或者 hotfix- 以外的名字都可以比如可以用 feature-*的方式命名。

**增加新功能**

```
git checkout -b feature/feature-plot

(dev)$: git checkout -b feature/xxx            # 从dev建立特性分支
(feature/xxx)$: blabla                         # 开发
(feature/xxx)$: git add xxx
(feature/xxx)$: git commit -m 'commit comment'
(dev)$: git merge feature/xxx --no-ff          # 把特性分支合并到dev
```



**修复紧急bug**

```
(master)$: git checkout -b hotfix/xxx         # 从master建立hotfix分支
(hotfix/xxx)$: blabla                         # 开发
(hotfix/xxx)$: git add xxx
(hotfix/xxx)$: git commit -m 'commit comment'
(master)$: git merge hotfix/xxx --no-ff       # 把hotfix分支合并到master，并上线到生产环境
(dev)$: git merge hotfix/xxx --no-ff          # 把hotfix分支合并到dev，同步代码
```



**测试环境代码**

```
(release)$: git merge dev --no-ff             # 把dev分支合并到release，然后在测试环境拉取并测试
```



**生产环境上线**

```
(master)$: git merge testing --no-ff          # 把testing测试好的代码合并到master，运维人员操作
(master)$: git tag -a v0.1 -m '部署包版本名'  #给版本命名，打Tag
```



**解决冲突**

```
 git log --graph --pretty=oneline --abbrev-commit
```





## TAG

采用三段式，v版本.里程碑.序号，如`v1.2.1`

- 架构升级或架构重大调整，修改第2位
- 新功能上线或者模块大的调整，修改第2位
- bug修复上线，修改第3位

Git跟其他版本控制系统一样，可以打标签（tag）标记一个版本号。

发布一个版本时，我们通常先在版本库中打一个标签，这样，就唯一确定了打标签时刻的版本。将来无论什么时候，取某个标签的版本，就是把那个打标签的时刻的历史版本取出来。所以，标签也是版本库的一个快照。

Git的标签虽然是版本库的快照，但其实它就是指向某个commit的指针（跟分支很像对不对？但是分支可以移动，标签不能移动），所以，创建和删除标签都是瞬间完成的。

### changelog

版本正式发布后，需要生产changelog文档，便于后续问题追溯。

## Git提交信息

message信息格式采用目前主流的**Angular规范**，这是目前使用最广的写法，比较合理和系统化，并且有配套的工具。