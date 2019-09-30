检索式对话系统

不带上下文



任务型对话

上下文



聊天型



任务型对话系统

![1556522699312](/home/star/Resources/Articles/assets/1556522699312.png)



意图识别：

目的：开放域还是特定域



slot填充： 

  request_movie

genre=action,data=this_weekeng



Dialogue Policy:



![1556523049622](/home/star/Resources/Articles/assets/1556523049622.png)





![1556523197922](/home/star/Resources/Articles/assets/1556523197922.png)



方法：

​      语义分析

​      语义标注

​     语义元组分类器

​     深度学习(tensorflow+crf)

![1556523240417](/home/star/Resources/Articles/assets/1556523240417.png)



DST（对话状态跟踪 Dialogue State Track）

![1556523395209](/home/star/Resources/Articles/assets/1556523395209.png)





![1556523475451](/home/star/Resources/Articles/assets/1556523475451.png)



生成模型：seq2seq

![1556523511150](/home/star/Resources/Articles/assets/1556523511150.png)



深度学习：

时间较慢

![1556523625228](/home/star/Resources/Articles/assets/1556523625228.png)







pipeline:

\- name: "nlp_mitie"

  model: "data/total_word_feature_extractor.dat"

\- name: "tokenizer_jieba"

\- name: "ner_mitie"

\- name: "ner_synonyms"

\- name: "intent_entity_featurizer_regex"

\- name: "intent_featurizer_mitie"

\- name: "intent_classifier_sklearn"



total_word_feature_extractor.dat： 可理解为预训练的词向量，训练时间很长



数据准备：



基于机器学习进行标注



# RASA NLU

聊天机器人的语言理解有很多种实现技术。主要solution有：对于用户输入问题进行**意图识别**和**实体提取**。

意图识别和语言提取可以通过基于规则（rule-based)）和基于模型（model-based）两种方式来实现。

采用一些成熟的分类算法（朴素贝叶斯、SVM、决策树、LR等），即可得到一个分类器。





# RASA DOCKER

## 初始化工程文件

```
docker run -v $(pwd):/app rasa/rasa init --no-prompt
```



## 运行

```
docker run -it -v $(pwd):/app rasa/rasa shell
```

这将启动一个shell，将当前目录挂载到docker中的/app目录，您可以在其中与助手聊天。

注意，这个命令包含-it标志,意味着您正在交互式地运行Docker，并且能够通过命令行提供输入。

对于需要交互输入的命令，比如rasa shell和rasa interactive，您需要传递-it标志



**命名容器**

```
docker run -it --name rasa_shell -v $(pwd):/app rasa/rasa:latest-full shell
```





##　定制模型

```
docker run \
  -v $(pwd):/app \
  rasa/rasa:latest-full \
  train \
    --domain domain.yml \
    --data data \
    --out models
```

`train`: 在容器中执行 `rasa train`命令

`rasa/rasa:latest-full`: 镜像标记，rasa/rasa为仓库名，latest-full为标签名

执行后，在modles目录中生成后缀为tar.gz的模型文件



## 测试模型

```
docker run -v $(pwd):/app rasa/rasa:latest-full test
```

评估模型



转换训练集格式

```
docker run -v $(pwd):/app rasa/rasa:latest-full data convert nlu -f md --data ./data/dsmart.json --out ./data/dsmart.md
```

Agent:

https://blog.csdn.net/zha6476003/article/details/80562860

https://blog.csdn.net/scott_bing/article/details/78613194