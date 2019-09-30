

Mainly to train all word vector features, the latter real name entity 
model and relational model are based on it, MITIE provides us with tools
to complete the above operations, we can use cmake to generate vs 
project, but generally we do not need to change To the code, use cmake 
to build it and use it directly.

主要是训练所有单词向量特征，实名实体模型和关系模型都是基于它。



This is a tool for turning a word into a short and dense vector which describes

 what kind of places in text a word can appear.  This is done based purely on

   morphological features of the word.

这是一个将单词转换为简短而密集的向量的工具。

 一个单词可以出现在文本中的哪个位置。 这完全基于这个词的形态特征。



词向量模型

词向量模型是考虑词语位置关系的一种模型。通过大量语料的训练，将每一个词语映射到高维度（几千、几万维以上）的向量当中，通过求余弦的方式，可以判断两个词语之间的关系，例如例句中的Jane和Bob在词向量模型中，他们的余弦值可能就接近1，因为这两个都是人名，Shenzhen和Bob的余弦值可能就接近0，因为一个是人名一个是地名。

常用word2vec构成词向量模型，它的底层采用基于CBOW和Skip-Gram算法的神经网络模型。

 CBOW模型

    CBOW模型的训练输入是某一个特征词的上下文相关的词对应的词向量，而输出就是这特定的一个词的词向量。比如上面的第一句话，将上下文大小取值为2，特定的这个词是"go"，也就是我们需要的输出词向量,上下文对应的词有4个，前后各2个，这4个词是我们模型的输入。由于CBOW使用的是词袋模型，因此这4个词都是平等的，也就是不考虑他们和我们关注的词之间的距离大小，只要在我们上下文之内即可。
    
    这样我们这个CBOW的例子里，我们的输入是4个词向量，输出是所有词的softmax概率（训练的目标是期望训练样本特定词对应的softmax概率最大），对应的CBOW神经网络模型输入层有4个神经元，输出层有词汇表大小个神经元。隐藏层的神经元个数我们可以自己指定。通过DNN的反向传播算法，我们可以求出DNN模型的参数，同时得到所有的词对应的词向量。这样当我们有新的需求，要求出某4个词对应的最可能的输出中心词时，我们可以通过一次DNN前向传播算法并通过softmax激活函数找到概率最大的词对应的神经元即可。
Skip-Gram模型

    Skip-Gram模型和CBOW的思路是反着来的，即输入是特定的一个词的词向量，而输出是特定词对应的上下文词向量。还是上面的例子，我们的上下文大小取值为2， 特定的这个词"go"是我们的输入，而这4个上下文词是我们的输出。
    
    这样我们这个Skip-Gram的例子里，我们的输入是特定词， 输出是softmax概率排前4的4个词，对应的Skip-Gram神经网络模型输入层有1个神经元，输出层有词汇表大小个神经元。隐藏层的神经元个数我们可以自己指定。通过DNN的反向传播算法，我们可以求出DNN模型的参数，同时得到所有的词对应的词向量。这样当我们有新的需求，要求出某1个词对应的最可能的4个上下文词时，我们可以通过一次DNN前向传播算法得到概率大小排前4的softmax概率对应的神经元所对应的词即可。

词向量模型突出特点：

    在词向量模型中，词向量与词向量之间有这非常特殊的特性。例如现在存在国王、男生、女人、皇后四个词向量，那么一个完善的词向量模型，就存在“国王-男人+女人=皇后”这样的关系