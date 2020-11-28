## MTurk 

MTurk is a online way to recruit subjects and perform tasks.

Some terminology

* HIT: Basically the task
* Requester: the experimenter
* Worker: the subjects

An [work through of a task](https://docs.aws.amazon.com/AWSMechTurk/latest/RequesterUI/CreatingYourBatchofHITs.html)  (Image classification)

A user side tutorial on [how to get Turker to assist annotate data. ](https://monkeylearn.com/blog/mechanical-turk-101-use-mturk-tagging-training-data/)

[Tim Brady tutorial](https://bradylab.ucsd.edu/ttt/)

### Qualification

There are ways to pre filter the subjects by defining qualification. ( there are some funny qualifications like have to participate in 2016 election etc.)

[Qualification](https://blog.mturk.com/tutorial-understanding-requirements-and-qualifications-99a26069fba2)

### Material Needed for a Task





### Coding the HTML form

See the note on html GUI and JavaScript. 

### Local Deployment

https://github.com/danvk/localturk



http://babieslearninglanguage.blogspot.com/2013/10/randomization-on-mechanical-turk_10.html

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