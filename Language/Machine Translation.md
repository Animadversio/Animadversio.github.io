机器翻译的源头是模仿人的翻译, 开始时是基于rule的翻译, 后面开始用统计与机器学习的方法 越做越好

##Human translation

Thought Process of Human translator

Language Learning(Human)

* Memorize words (vocabulary building)
* Word Pattern , Phrases Thesaurus, Wordnet 学习固定搭配 用于翻译词组
* Grammar 
* Exercise: 
  * Reading, Writing, (Listening, Speaking)
  * *Reinforcement Learning!!* 

Translation

* ​



MT Tools

* Part-of-speech tagger, Tokenizer, Parser, Tree-generator…

## Early Rule Based Translation

> When I encounter some document in Russian, I says that's really written in English, but coded in some strange symbols, I'll now proceed to decode it. 
>
> — Warren Weaver

Cryptographer的想法, 用密码破译的观点看语言翻译. 然而结果很差

> Language in , Garbage out. 

词词对翻译的问题!

* 词组翻译有问题
* Syntax, Word order
* 句法中的 性数相合 这样在的配合! 



### Example: TAU Meteo

加拿大用于翻译天气预报的一套系统, 几乎是唯一一套Rule Based system, 能英语法语之间工作, 不用干预

超越词的对应 要在句子 的意义上解决

## Syntax Linguistics

1950-1970

* Structural Linguistics — 1950s
* Generative Linguistics — 1950年后 Chomsky开创的学派, 在
  * Basic idea: 通过有限数量的rules 可以生成无限的句子
  * 强调形式化的语法结构
  * 1957 Synatactic Structures
* 语言表示的形式化, 把形式语法放在理论语言学的中心
* -> Parser: 分析词的性质


Structuralism 

### Syntatic Analysis Tree

* **Constituency**: 
  * 词如何组成更大的组分 N, V-> NP, VP->S
  * 句法树
* 将线性的Linear Sequence 组织成Tree的形态! 更深的语义表示


* **Dependency** :
  * 以**main verb为中心**, 找其他词跟verb的关系! Cf. [Latin](Latin Grammar.md) 
  * *Éléments de syntaxe structurale*
  * Agent, Accusitive, Adjective
  * 另一种解析语句生成树状结构的方式 

**Note:** Parser 是一个Trial and Error 的过程, 如果每个词有多重属性! 

### Transformational Generative Grammar

* **Transformation**: 关注不同表达之间的Transformation Rule 
* 比如学习语言时: 变成疑问句, 变成被动, 变成分词表达, 变成强调句. 都是在训练我们的Transformational ability!! 
  * S1: NP1-V-NP2
  * S2: NP2 be V-en by NP1. 
* **Generative**: 相同的Rule可以generate无穷的内容

### Formalized Semantic Analysis

* Verb可以接的Object Subject需要有相应属性!! 
* E.g. "Write"- 
  * Subject-should be animated and human
  * Object should be writabe inanimated
  * "Piano writes me"- X
* Cf. C++ 每个 Operator 可以接的Variable类型/ 属性有限制! 变量类型检查!! 

## Rule Based Machine Translation

RBMT

### Word-Word Translation

* 实意词对应翻译, 对于语法结构Rearrange一下
* 规则就是一组巨大的If Else 判断树! 
* 但事实上, 很难概括所有情况! 



### Transfer approach vs Interlingua approach

* **Transfer**: 两种语言之间的翻译
* **Interlingua**:  翻译到一种中间表示, 再到各种语言
  * Pursue a intermediate, specific language independent, semantic representation
    * Universal logical grammar: **OK** 逻辑非, 逻辑算符
    * "John must not go"-`OBIGATORY(NEGATIVE(GO(JOHN)))` 
  * 问题是, 不同语言的语言细节区分很不一样! 有重合有不重合的. 
  * Universal Representation可能会失去许多细节. 
  * 所以真的存在 Language independent meaning representation? 

### Example-based Translation

> A good translator is a lazy translator.

* 调用原有的词组, 段落, 风格进行翻译
* 找到Example database中对句子Segment-词组的翻译
* 可以大大加强Consistency!! 
  * 有些时候命名一致性非常重要: 法律文献 医学文献

Component:

* Database of translated text
* Matching Algorithm
* Combining and Reorganizing

Con: 

* Translated Text中, 对应的词组怎么提出来是个Non-trivial问题! 现有Align算法错误率很高, 不好用
* Matching许多时候找不到Perfect Match那么怎么翻译? 怎么在不Perfect的Match中找一个好的出来



### General Challenges

* Syntactic Ambiguity: 
  * "The boy saw the man with a telescope"人也会遇到歧义性
* Pronoun reference resolution 指代问题
  * ​
* Long distance dependency 语序巨大变化, object 可能与Verb相距甚远, 不一定找得到 (日常语言使用 不那么遵循语法!!!! )
  * Topicalization: "Ann, I love her"
  * It-Cleft: "It's Ann that I loved much"
  * Wh questions: 
  * Relative Clause: 先行词也不一定紧接着引导词(Reletive Pronoun)! 许多时候需要语义知识来判定修饰的是哪个词!! 

**What is Relative Pronoun?** 

* Chomsky: "Wh-movement" 
* "Constraint on long distance dependency": 什么样的deendency不能出现! 不合法

之后语言学在Rule-based这条路上停滞不前, 语言学与计算机翻译分手啦!! 

-----------

## Statistical MT

### Empiricism Philosophy

* Peak in 1950:
  * Behaviorism in Psychology
  * Information Theory in EE
  * Word Company determines meaning! 
* Back in 1990
  * 大量data来了!! Brown Corpus
  * 所以风向变了: 从对特定问题的深度分析-> 对没有限制的大量data的广度分析

### Algorithm

* 首先有了大量的Bilingal Corpora, 
  * 比如法国 欧盟议会的记录都有大量语言的翻译
* 然后开发出了Alignment算法
* 找到一种算法估计法语词被翻译成某个英语词的概率!! 
* 核心是一个语言间翻译模型(条件概率模型)
  * 去估计概率$p(f|e)$, 以及给定Context的条件概率$p(f|e,e_1,e_2,e_3….)$ 
* 另外是单个语言模型, 去估计某个表达在法语中的出现概率! $p(f)$ 
  * 如果某个词组不常见, 则容易被拒绝
* $p(f|e),p(f)$ 都很高则OK

### Brown Model

* Fertility
* Word for word translation
* Reorganization
* Spurious word insertion



— Statistical Machine Translation 只需要Parallel Data. 



### IBM Models

* **Sentence Alignment** 哪句是哪句的翻译
  * Length feature: 长句和长句更可能匹配
  * Lexical Feature: 相似的词代表两个句子可能相似
  * 大多数时候, 所有Feature用上效果非常好
* **Word Alignment/ Phrase Alignment** 
  * 不只需要Bilingal dictionary! 
    * 字典不一定给了实际的form
    * 实际的翻译可能超出了字典的用法
  * 许多时候是词组对词组的翻译, 而非单个词
* **Reordering Model**
  * 怎样从Corpora学出来这种Transformation Rule?
  * 或者从Language Model中 rank 不同句子的可能性大小整个句子不好估计时可以通过估计其中n-gram的出现概率来估计整体. (Markov Chain Model/ n-gram model)
  * n-gram的概率很好估计$P(t_2\mid t_1)=P(t_2t_1)/P(t_1)$ 

$$
P(t_{1}t_{2}t_{3})=P(t_1)P(t_{2}\mid t_1)P(t_3\mid t_{1}t_{2})\\
P_{Uni}(t_1t_2t_3)=P(t_1)P(t_2)P(t_3)\\
P_{Bigram}=P(t_1)P(t_2\mid t_1)P(t_3\mid t_2)\\
...
$$

http://homepages.inf.ed.ac.uk/lzhang10/slm.html

http://www.speech.cs.cmu.edu/SLM_info.html

---------

## Neural Language Model

https://machinelearningmastery.com/statistical-language-modeling-and-neural-language-models/

http://www.scholarpedia.org/article/Neural_net_language_models

### Philosophy

Bengio 2002

* 寻找Word 的Features 并Distributed Represent! 
  * Distributed Representation 可以大大降低维度, 不再是每个词一个单元, 而是许多单元表示大量词. 表示能力是$2^n$ 指数的!
  * 神经网络模型有这种分布式表示Word的能力
* 不再强行用n-gram estimate, i.e. 机械的只使用一定长度的Context信息, 而是
  * 将n-word context变换成Feature vector, 然后再以一个分类问题(Softmax output)去predict next word
* 目标函数: 看训练集中Sentense的Log-likelihood. (最大化真正句子的Probability)

### Challenge

* 真正实施这一算法有些技巧. 否则inference太慢. 在输出层需要计算所有十万个词的概率, 非常Slow!! 
  * 或许可以用Decision Tree迅速剪枝 来简化计算$O(log(n))$ 复杂度
  * 或者存下来一些常用结果, 不用每次计算
* Semantic Abstraction可能需要Deep Network?
* Training Data size有多大的影响





