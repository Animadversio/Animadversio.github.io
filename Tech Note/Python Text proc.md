## 中文读写

Python文件读取 主要是`open`, `file`两种, 以这两个函数建立与文件的接口, 从而可以读写. 注意有时处理中文用`'rb'`模式而非`r` 

`f=open("红楼梦UTF.txt",'rb')` 

从文件到字符串: `f.read()`, `f.readline()` `f.readlines()` 

```python
for line in fp.readlines()：#逐行处理文本文件
	
```

注意输出显示时编码选择好 `print(line.decode('gb2312'))` 



## 中文正则表达式



**正则表达式总结**

http://blog.csdn.net/TheMinority/article/details/7629227



**位置**: `$` `\A` 匹配结尾, `^` `\Z` 匹配字符串开始

**字符集**: `.`换行之外任何字符, `[…]`匹配框中字符 `[0-9]`数字 `\d` 代表任何数字 `\D`表示 非任何数字 `\s` 任何空格
`\w` 代表任何数字字母 `[A-Za-z0-9_]`同意`[\u4e00-\u9fa5]`代表任何汉字

**次数**(加在字符或字符集后面): `.*` 可表达任意字符0或多次; `?` 0或1次; `+` 一次或多次; `*`0次或多次; `{M,N}`表示M-N次

 `.*?`可以非贪心匹配任何字符串 指导后面的字符出现. 

附注: 编译标志

   > 编译标志让你可以修改正则表达式的一些运行方式。在 re 模块中标志可以使用两个名字，一个是全名如 IGNORECASE，一个是缩写，一字母形式如 I。（如果你熟悉 Perl 的模式修改，一字母形式使用同样的字母；例如 re.VERBOSE的缩写形式是 re.X。）多个标志可以通过按位 OR-ing 它们来指定。如 re.I | re.M 被设置成 I 和 M 标志：
   > I IGNORECASE
   > 使匹配对大小写不敏感；字符类和字符串匹配字母时忽略大小写。举个例子，[A-Z]也可以匹配小写字母，Spam 可以匹配 "Spam", "spam", 或 "spAM"。这个小写字母并不考虑当前位置。
   > L LOCALE
   > 影响 "w, "W, "b, 和 "B，这取决于当前的本地化设置。
   > locales 是 C 语言库中的一项功能，是用来为需要考虑不同语言的编程提供帮助的。举个例子，如果你正在处理法文文本，你想用 "w+ 来匹配文字，但 "w 只匹配字符类 [A-Za-z]；它并不能匹配 "é" 或 "?"。如果你的系统配置适当且本地化设置为法语，那么内部的 C 函数将告诉程序 "é" 也应该被认为是一个字母。当在编译正则表达式时使用 LOCALE 标志会得到用这些 C 函数来处理 "w 後的编译对象；这会更慢，但也会象你希望的那样可以用 "w+ 来匹配法文文本。
   > M MULTILINE
   > (此时 ^ 和 $ 不会被解释; 它们将在 4.1 节被介绍.)
   > 使用 "^" 只匹配字符串的开始，而 `$` 则只匹配字符串的结尾和直接在换行前（如果有的话）的字符串结尾。当本标志指定後， "^" 匹配字符串的开始和字符串中每行的开始。同样的， `$` 元字符匹配字符串结尾和字符串中每行的结尾（直接在每个换行之前）。
   > S DOTALL
   > 使 "." 特殊字符完全匹配任何字符，包括换行；没有这个标志， "." 匹配除了换行外的任何字符。
   > X  VERBOSE
   > 该标志通过给予你更灵活的格式以便你将正则表达式写得更易于理解。当该标志被指定时，在 RE 字符串中的空白符被忽略，除非该空白符在字符类中或在反斜杠之後；这可以让你更清晰地组织和缩进 RE。它也可以允许你将注释写入 RE，这些注释会被引擎忽略；注释用 "#"号 来标识，不过该符号不能在字符串或反斜杠之後。



### 中文检索, 匹配

str自带的`find`方法很容易写出findall程序

```python
def findallPOS(text,search,start = 0,end=-1):
    POSlist=[]
    while True:
        index = text.find(search, start)
        # if search string not found, find() returns -1
        # search is complete, break out of the while loop
        if index == -1 or (end>0 and index>end):
            break
        POSlist.append(index)
        #print( "%s found at index %d" % (search, index) )
        # move to next possible start position
        start = index + 1
    return POSlist
```

Credit to http://blog.csdn.net/wudiyi815/article/details/7775189

### 字数统计

中文字数 需要去除分隔符

```python
def WordCount(corp):
    SectSentenSplit=re.split("[，：“\"”`'。．”！？\s$]*",corp)
    charcnt=0
    for phrase in SectSentenSplit:
        charcnt+=len(phrase)
    print("字数(汉字): ",charcnt)
    return charcnt
```


## 分词算法

结巴分词: https://github.com/fxsjy/jieba

比较文档相似度: https://my.oschina.net/kakablue/blog/314513

## 可视化

### matplotlib中文

中文字体英文名 以及 不同方式对比: http://www.cnblogs.com/hhh5460/p/4323985.html

http://www.cnblogs.com/taceywong/p/5468224.html

```python
def conf_zh(font_name):
    from pylab import mpl
    mpl.rcParams['font.sans-serif'] = [font_name]
    mpl.rcParams['axes.unicode_minus'] = False 

conf_zh("Droid Sans Fallback")
plt.title(u'matplotlib中文显示测试——Tacey Wong') 
plt.xlabel(u'这里是X坐标')
plt.ylabel(u'这里是Y坐标')
```

简单 粗暴解决方案

```python
FontProperties(fname='/System/Library/Fonts/PingFang.ttc')  
plot.title(u"我是道哥", fontproperties=getChineseFont())  
```

Mac 专门解决方案: http://blog.csdn.net/Fantasy_Muse/article/details/78585049

1. 导入SimHei的tff文件到`…matplotlib/mpl-data/fonts/ttf`

2. 找到目录`matplotlib.matplotlib_fname()` 修改`matplotlibrc` 文件

3. 清空缓存!! `~/.matplotlib/FontList.json`文件清除之后, 重启Matplotlib才能生效

4. 使用时设置默认

   ```python
   plt.rcParams['font.sans-serif']=['SimHei']# 设置加载的字体名  
   plt.rcParams['axes.unicode_minus']=False #解决保存图像是负号'-'显示为方块的问题 
   ```


   ​