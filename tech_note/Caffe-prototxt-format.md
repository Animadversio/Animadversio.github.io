# How do we write a Caffe prototxt?

http://vision.stanford.edu/teaching/cs231n/slides/2015/caffe_tutorial.pdf

`prototxt` is approximately JSON. But it's strongly typed!

* The types are defined as `message` in a `*.proto` file. 
* For example all the message types of [Caffe](https://github.com/BVLC/caffe/blob/85bb397acfd383a676c125c75d877642d6b39ff6/src/caffe/proto/caffe.proto). 
* 