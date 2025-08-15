---
layout: post
title: MTurk 101
author: Binxu Wang
date: 2020-11-21
comments: true
categories: [coding]
tags: [tech note, Neuroscience, psychology, behavior, web, psychophysics]
---

## MTurk 

MTurk is a online way to recruit subjects and perform tasks, widely used in psychology and machine learning to collect human perception and behavior data. 

Some terminology: 

* HIT: Basically the task
* Requester: the experimenter
* Worker: the subjects

An [work through of a task](https://docs.aws.amazon.com/AWSMechTurk/latest/RequesterUI/CreatingYourBatchofHITs.html)  (Image classification)

A user side tutorial on [how to get Turker to assist annotate data. ](https://monkeylearn.com/blog/mechanical-turk-101-use-mturk-tagging-training-data/)

[Tim Brady tutorial](https://bradylab.ucsd.edu/ttt/)

### Qualification
Quality of subjects and how attentive they are to your task has enormous effect on the quality of data you get from it, so you definitly want quality control there.

There are ways to pre filter the subjects by defining qualification. ( there are some funny qualifications like have to participate in 2016 election etc.)

[Qualification](https://blog.mturk.com/tutorial-understanding-requirements-and-qualifications-99a26069fba2)

Besides, add catch trials to find the subjects that are not really doing the work. Requesters can refuse to pay for them based on their performance. 

### Material Needed for a Task

* An online repository to store the resources e.g. images. 
	* Usually an Amazon AWS storage service like S3 will suffice. 
* Account for Amazon Mechanical Turk as requestor. (Maybe as worker.)
* HTML, JS script for the task. 
* CSV table containing the variable values for each individual trial. 
* Money and your card. (You can prepay or just link a card.)
* Publish the task! Recruit subjects. 

### Randomization
http://babieslearninglanguage.blogspot.com/2013/10/randomization-on-mechanical-turk_10.html

### Coding the HTML form

See the note on [html GUI and JavaScript]({{< relref "HTML-JS-101.md" >}})

### Local Deployment

https://github.com/danvk/localturk
Note this is not super up to data, so may not work with the most recent APIs. 


## psiTurk

http://gureckislab.org/mtworkshop/#1

https://psiturk.readthedocs.io/en/python2/stroop.html

psiTurk is one layer complication / abstraction over MTurk itself, which makes it more customizable and amenable for complex cognitive tasks. 

> The **psiTurk** toolbox is designed to help you run fully-customized and dynamic web-experiments on AMT. Specifically, it allows you to:
>
> 1. Run a web server for your experiment
> 2. Test your experiment
> 3. Interact with AMT to recruit, post HITs, filter, and pay participants (AMT workers)
> 4. Manage databases and export data

Note, psiTurk experiment need a computer with a public port to host it. 



### Caveat

PsiTurk is not supported on Windows.

## Economy of MTurk

Referring to [Monkey Learn](https://monkeylearn.com/blog/mechanical-turk-101-use-mturk-tagging-training-data/)

> Let’s do the maths. A typical worker who earns the minimum wage in San Francisco (~USD 13 per hour) will annotate 180 samples per hour (at 20 seconds per sample). This means that if you hired the worker, you would have to spend USD 72 per 1,000 samples.