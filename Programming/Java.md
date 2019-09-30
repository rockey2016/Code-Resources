---

---



注解



参考：

https://www.cnblogs.com/yangming1996/p/9295168.html



# 反射机制

## 概念

反射是在JVM运行的时候通过Class对象动态的获取类信息，不需要事先写好代码及用编译器编译，而是直接在JVM运行过程中拿到类的方法等信息直接执行。

## 获取Class对象

**方法一**：通过字面量直接获取，如XXX.class，值得注意的是这种字面量不会触发类的初始化，但此时方法区中肯定已经有了XXX类的Class对象，因此可以推断XXX类已经被加载到方法区，只是没有完成初始化，实际上初始化就是给类中定义的类变量和成员变量及静态代码块进行初始化赋值和执行操作，初始化完的类程序员才真正可以new出来。

 **方法二**：通过Object类的getClass方法，如xxxObject.getClass()，这种方法会触发类的初始化。

 **方法三**：通过Class的静态方法forName（）触发类的初始化。



参考：

https://www.jianshu.com/p/516228c2acfd

# classLoader

## class文件

- class文件是字节码格式文件，java虚拟机并不能直接识别我们平常编写的.java源文件，所以需要javac这个命令转换成.class文件。

- 用C或者PYTHON编写的程序正确转换成.class文件后，java虚拟机也是可以识别运行的。

## 类加载流程

Java语言系统自带有三个类加载器:

- Bootstrap ClassLoader 最顶层的加载类，主要加载核心类库%JRE_HOME%\lib下的rt.jar、resources.jar、charsets.jar和class等。注意：通过启动jvm时指定-Xbootclasspath和路径来改变Bootstrap ClassLoader的加载目录。比如java -Xbootclasspath/a:path被指定的文件追加到默认的bootstrap路径中。
- Extention ClassLoader 扩展的类加载器，加载目%JRE_HOME%\lib\ext目录下的jar包和class文件。还可以加载-D java.ext.dirs选项指定的目录。
-  Appclass Loader也称为SystemAppClass 加载当前应用的classpath的所有类。

详细参考：

https://blog.csdn.net/briblue/article/details/54973413#comments

# 参考

https://blog.csdn.net/shengzhu1/article/details/81271409