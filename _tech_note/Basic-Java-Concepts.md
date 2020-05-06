## Motivation

This brief note doesn't venture to introduce Java. But it's trying to give a conceptual setting when encountering JAVA program vs python and C++ which I'm more familiar with. 



## Concepts

If you will, Java sits in the middle of C++ and Python. In the sense that, 

* it is compiled to a middle level `bytecode` like C++, using java compiler `javac` 
  * But unlike C++ this code could be the same on different machines. 
* But when running it's run on a Java Virtual Machine (JVM), this is different from platform to platform, but can execute the same compiled java file. This part it is a interpreted language, just like Python. Through this it achieves platform independence largely. 
  * `java` is that interpreter or an implementation of `JVM` .

So it gets many pros and cons of both side

* So like Python, as it's run in an environment, it's error could get better handled than C++. You will see stack trace! 
* Like C++ when you change the code you need to recompile the code for it to run. 
  * So it's advisable to put the configurations and data totally outside code, you don't need to change the compilation to change configuration
  * In python, change configuration in script is totally fine! 
  * Besides, compilation go through the code before running it. So type based error could be found quite easily.
  * Moreover, it compiles much faster than C++ and run faster than native Python. 



Unique part about Java is it's object oriented down to the root. So everything is class, mostly it's used as library. But when it's run, there should be an entry point, like start of the game program. Then there should be a main class and a main method in it. 

## Compilation

Just like C++, compilation is no easy task and requires configurations and dependencies. `gradle` is one such tool to help configure compilation. 



## Syntactic Feature

**Similarity to C++**

* `;` and `{}` are over used. If and for loop need `()` and for loop has the same syntax with C++
* It's strong type language like C++. So class inherentance become more useful. 



**Similarity to Python**

* module import is quite similar to python
* `.` access to attributes and methods like python. 