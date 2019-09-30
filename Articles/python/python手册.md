

# IPYTHON

交互模式下运行IPython笔记本

```
ipython notebook
```



magic function

```
%magic
%quickref
```



# PYTHON概要

## 数据类型

|    类型    | 格式                             |
| :--------: | -------------------------------- |
|   布尔型   | True,False                       |
|    整型    | 100                              |
|   长整型   | 1000000000L                      |
|   浮点型   | 3.14                             |
|   字符串   | 'hello'                          |
|    元祖    | ('ring',100)                     |
|    集合    | {1,2,3}                          |
|  字典dict  | {'color':'red','shape':'square'} |
| Numpy数组  | array([1,2,3])                   |
|  列表List  | [1,1.2,'hello']                  |
|   Pandas   | DataFrame,Series,Index           |
| 自定义类型 | Object Orient Class              |
|            |                                  |
|            |                                  |

### 字符串操作

**Python**中可以使用一对单引号''或者双引号""生成字符串。

```python
s1 = "hello, world"
s2 = 'hello world'
print s1
print s2
```

```
hello, world
hello world
```



#### 分割

s.split()将s按照空格（包括多个空格，制表符`\t`，换行符`\n`等）分割，并返回所有分割得到的字符串。

```python
line = "1 2 3 4  5"
numbers = line.split()
print numbers
```

```
['1', '2', '3', '4', '5']
```





#### 连接

```python
s1 = 'hello ' + 'world'
s2 = "echo" * 3
```

s.join(str_sequence)的作用是以s为连接符将字符串序列str_sequence中的元素连接起来，并返回连接后得到的新字符串：

```
s1 = ' '
s1.join(numbers)
s2 = ','
s2.join(numbers)
```

Out:

```
'1 2 3 4 5'
'1,2,3,4,5'
```



**查看函数方法**

可以使用dir函数查看所有可以使用的方法



#### 多行字符串

Python 用一对 `"""` 或者 `'''` 来生成多行字符串：

```
a = """hello world.
it is a nice day."""

b = 'hello world.\nit is a nice day.'
```



#### 换行

当代码太长或者为了美观起见时，我们可以使用两种方法来将一行代码转为多行代码：

- ()

- \

  ```
  a = ("hello, world. "
      "it's a nice day. "
      "my name is xxx")
      
  b = "hello, world. " \
      "it's a nice day. " \
      "my name is xxx"
  ```

  

#### 强制转换为字符串

  - `str(ob)`强制将`ob`转化成字符串。 
  - `repr(ob)`也是强制将`ob`转化成字符串。

```
str(1.1 + 2.2)

repr(1.1 + 2.2)
```

OUT:

```
'3.3'
'3.3000000000000003'
```



#### 格式化字符串

**Python**用字符串的`format()`方法来格式化字符串。

具体用法如下，字符串中花括号 `{}` 的部分会被format传入的参数替代，传入的值可以是字符串，也可以是数字或者别的对象。

```
s1 = '{} {} {}'.format('a', 'b', 'c')
s2 = '{2} {1} {0}'.format('a', 'b', 'c')
s3 = '{color} {n} {x}'.format(n=10, x=1.5, color='blue')
```

也可以使用旧式的 `%` 方法进行格式化：

```
s = "some numbers:"
x = 1.34
y = 2
# 用百分号隔开，括号括起来
t = "%s %f, %d" % (s, x, y)
```





# Pandas

## Functions

read_csv

```python
pd.read_csv(
    filepath_or_buffer,
    sep=',',   #字段分隔符
    delimiter=None,
    header='infer',
    names=None,
    index_col=None, #字符串格式，以某列作为索引
    usecols=None,
    squeeze=False,
    prefix=None,
    mangle_dupe_cols=True,
    dtype=None,
    engine=None,
    converters=None,
    true_values=None,
    false_values=None,
    skipinitialspace=False,
    skiprows=None,
    skipfooter=0,
    nrows=None,
    na_values=None,
    keep_default_na=True,
    na_filter=True,
    verbose=False,
    skip_blank_lines=True,
    parse_dates=False,         #以某列作为日期
    infer_datetime_format=False,
    keep_date_col=False,
    date_parser=None,
    dayfirst=False,    #待解析日期格式开始以dd开始
    iterator=False,
    chunksize=None,
    compression='infer',
    thousands=None,
    decimal=b'.',
    lineterminator=None,
    quotechar='"',
    quoting=0,
    doublequote=True,
    escapechar=None,
    comment=None,
    encoding=None,
    dialect=None,
    tupleize_cols=None,
    error_bad_lines=True,
    warn_bad_lines=True,
    delim_whitespace=False,
    low_memory=True,
    memory_map=False,
    float_precision=None,
)
```



## DataStructure

### DataFrame

#### 概述

DataFrame是由索引相同的Series构成的的一二维数据结构。

**四个重要属性**

- DataFrame.index
- DataFrame.columns
- DataFrame.values
- DataFrame.dtypes

#### 操作

```
#查询某一列，[列名]
fixed_df['Berri 1']
#某一列趋势图
fixed_df['Berri 1'].plot()
#设置图像大小
fixed_df.plot(figsize=(15, 10))

#获取多列
fixed_df[['Berri 1','Maisonneuve 1']]

# 确定某列数据出现的频率,并以直列图形式显示
fixed_df['Berri 1'].value_counts()
fixed_df['Berri 1'].value_counts()[:10]
fixed_df['Berri 1'].value_counts()[:10].plot(kind='bar')
```



```pandas
#按行切片
##要获得数据fixed_df的前5行，可以使用切片
fixed_df[：5]
##获取列'Berri 1'的前5行
fixed_df['Berri 1'][：5] 或 fixed_df[：5]['Berri 1']
```



***过滤操作***

```
#获取列'Complaint Type'值为"Noise - Street/Sidewalk"的数据
noise_complaints = complaints[complaints['Complaint Type'] == "Noise - Street/Sidewalk"]
分解：
'''
下面语句的结果是得到一个大数组，值为True和False。
用这个数组索引我们的dataframe时只得到布尔数组求值为True的行。
注意:对于布尔数组的行过滤，dataframe索引的长度必须与用于过滤的布尔数组的长度相同
'''
complaints['Complaint Type'] == "Noise - Street/Sidewalk"
0      True
1     False
2     False
3     False
4     False
5     False
6     False
7     False
#用&组合多个过滤条件
is_noise = complaints['Complaint Type'] == "Noise - Street/Sidewalk"
in_brooklyn = complaints['Borough'] == "BROOKLYN"
complaints[is_noise & in_brooklyn][:5]
```



高级操作

```
# 某列数据的占比
is_noise = complaints['Complaint Type'] == "Noise - Street/Sidewalk"
noise_complaints = complaints[is_noise]

noise_complaint_counts = noise_complaints['Borough'].value_counts()
complaint_counts = complaints['Borough'].value_counts()

(noise_complaint_counts / complaint_counts.astype(float)).plot(kind='bar')
```



### Data

```
#根据某一列创建新的DataFrame
berri_bikes = bikes[['Berri 1']].copy()
berri_bikes.index
'''
out:
<class 'pandas.tseries.index.DatetimeIndex'>
[2012-01-01, ..., 2012-11-05]
Length: 310, Freq: None, Timezone: None
'''
#使用loc增加某一个新列 工作日
berri_bikes.loc[:,'weekday'] = berri_bikes.index.weekday
#按工作日对行进行分组，然后将具有相同工作日的所有值相加
weekday_counts = berri_bikes.groupby('weekday').aggregate(sum)
#重命名Index
weekday_counts.index = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
```



每个numpy数组和pandas Series都有一个dtype——通常是int64、float64或object。

一些可用的时间类型是datetime64[s]、datetime64[ms]和datetime64[us]。类似地，还有时间增量类型。

可以用pd将整数时间戳转换为datetimes。这是一个固定时间的操作——我们实际上并没有改变任何数据，只是Pd如何看待它。

```
popcon['atime'] = pd.to_datetime(popcon['atime'], unit='s')
popcon = popcon[popcon['atime'] > '1970-01-01']

#使用pandas的魔法字符串功能来查看包名称不包含'lib'的行
nonlibraries = popcon[~popcon['package-name'].str.contains('lib')]
```



#### Index

Index是构成和操作Series、DataFrame的关键，其具有元组特性。

**三个重要属性**

- Index.name

- Index.values

- Index.dtype

  

### Series

#### 概述

Series是由数据类型相同的元素构成的一维数据结构，具有列表和字典的特性。

**四个重要属性**

- Series.index
- Series.name
- Series.values
- Series.dtype

```

```





#### 构建

```
pd.Series([1,2,3])
#Series内部数据是numpy数组
pd.Series([1,2,3]).values

arr = np.array([1,2,3])
arr != 2 #得到值为True和False的array
arr[arr != 2] #获取arr中所有制不为2的元素
```



# 可视化

## import

```
# The usual preamble
%matplotlib inline
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Make the graphs a bit prettier, and bigger
pd.set_option('display.mpl_style', 'default')
plt.rcParams['figure.figsize'] = (15, 5)

pd.set_option('display.width', 5000) 
pd.set_option('display.max_columns', 60)
```

matplotlib

```
plt.figure(figsize=(10,6)) 

plt.xlable()
plt.xlim(-5,5) #设置x轴取值范围
plt.xticks([-5,-2.5,0,2.5,5],['-5','0','5']) #设置x轴刻度
plt.plot(x,y,color='red',linewidth=5.0,linestyle=':',lable='y=sin(x)')
plt.legend(loc='lower right')   #添加图形lable,并调用legend()
```



```
plt.figure(num='sin') #通过num指定画布
plt.plot(x,y)

plt.figure(num='cos')
plt.plot(x,y)

plt.figure(num='sin')
plt.plot(x,y,'r')
```



```
'''
(2,2,1)
1 2
3 4
'''
plt.subplot(2,2,1) #
plt.plot(x,x,'r')
plt.subplot(2,2,1)
```



```
#散点图,c颜色,s大小，alpha透明度，marker点形状
C=np.random.rand(1024)
S=np.random.rand(1024)
plt.scatter(x,y,c=C,s=S)
```



```
#柱状图 bar,facecolor柱体颜色，edgecolor边缘颜色
x=np.arange(12)
y=np.random.uniform(0.5,1,12)*(1-x/float(12))
plt.bar(x,y,facecolor='green',edgecolor='red')

#zip(x,y) 组合，x-y两两配对,y浮点数显示两个小数位
for x,y in zip(x,y):
    plt.text(x+0.1,y+0.01,'%.2f'%y,h='center',va='bottom')
```



