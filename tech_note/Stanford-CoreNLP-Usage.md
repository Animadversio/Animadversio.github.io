

## NLTK Old API to Stanford NLP

```cmd
set CLASSPATH=E:\DL_Projects\NLP\stanford-segmenter-4.0.0\stanford-segmenter.jar
set STANFORD_SEGMENTER_PATH="E:\DL_Projects\NLP\stanford-segmenter-4.0.0"
```

A pure python demo of this API. 

```python
os.environ['CLASSPATH'] = r"E:\DL_Projects\NLP\stanford-segmenter-4.0.0\stanford-segmenter.jar" # this is used to run the jave code
os.environ["STANFORD_SEGMENTER"] = r"E:\DL_Projects\NLP\stanford-segmenter-4.0.0" # this is used to search for dictionaries
segmenter = StanfordSegmenter()
segmenter.default_config('zh')
res = segmenter.segment(u"北海已成为中国对外开放中升起的一颗明星")
print(res)
# segmenter = StanfordSegmenter(
#     path_to_sihan_corpora_dict=r"E:\DL_Projects\NLP\stanford-segmenter-4.0.0\data",
#     path_to_model=r"E:\DL_Projects\NLP\stanford-segmenter-4.0.0\data\pku.gz",
#     path_to_dict=r"E:\DL_Projects\NLP\stanford-segmenter-4.0.0\data\dict-chris6.ser.gz" )
```

This is a really well documented demo of old API

zmonster.me/2016/06/08/use-stanford-nlp-package-in-nltk.html



## NLTK Stanford New API

https://codingcat.cn/article/58

https://stanfordnlp.github.io/CoreNLP/cmdline.html

```cmd
java -Xmx2g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLP -file input.txt
```

The current issue is not enough heap space for this program! 2g will not initialize JVM. 1200 will out of memory in the middle. 

NLTK interface with CoreNLP, the new one. 

https://github.com/nltk/nltk/wiki/Stanford-CoreNLP-API-in-NLTK



Windows classpath is separated by `;` linux it's by `:` 

`**set CLASSPATH=**`*classpath1*`**;**`*classpath2*...

https://medium.com/the-artificial-impostor/nlp-four-ways-to-tokenize-chinese-documents-f349eb6ba3c3