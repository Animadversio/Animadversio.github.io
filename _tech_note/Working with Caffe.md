## Installation

Official note on installation https://caffe.berkeleyvision.org/installation.html

### Installing CPU version on CHPC

* Install [Miniconda]()

* Install caffe using conda`conda install -c intel caffe`



> lsb_release -d
> Description:    CentOS release 6.10 (Final)

### Building GPU version on CHPC

(Not succeeded yet.... aborted)

1. Check `gcc` version to be 4.8.5 `module load gcc-4.8.5`
2. Check cmake version to newer than 3 `module load cmake-3.14.5`

**Reference** 

 http://www.andrewjanowczyk.com/installing-caffe-on-the-ohio-super-computing-osc-ruby-cluster/ 

http://homepage.cs.uiowa.edu/~zli79/notes/Installation_Caffe_on_Argon_Cluster.pdf



### Installing GPU version on CHPC

https://anaconda.org/anaconda/caffe-gpu

Just use miniconda, and `conda install -c anaconda caffe-gpu`

## Testing Installation

Starting by submitting a gpu job `qsub -I -l nodes=1:ppn=1:gpus=1,walltime=01:00:00 `

After downloading some weights for models by using 

```bash
python download_model_binary.py ../models/bvlc_reference_caffenet/
```

We have enough material to test loading a network into memory. 

Test CPU installation, 

```python
import caffe
import os.path
caffe.set_mode_cpu()
net_weights = os.path.join("/home/binxu/caffe/models/bvlc_reference_caffenet/", 'bvlc_reference_caffenet.caffemodel')
net_definition = os.path.join("/home/binxu/caffe/models/bvlc_reference_caffenet/", 'deploy.prototxt')
net = caffe.Net(net_definition, caffe.TEST, weights=net_weights)

net.blobs['data'].data[...] = 1
net.forward(end='fc6')
```

Test GPU installation, just use `caffe.set_mode_gpu()`

[Berkeley Model zoo](http://caffe.berkeleyvision.org/model_zoo.html )