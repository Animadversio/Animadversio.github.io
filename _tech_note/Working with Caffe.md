## Installation

### Installing on CHPC

Install [Miniconda]()

Install caffe using intel

`conda install -c intel caffe`



> lsb_release -d
> Description:    CentOS release 6.10 (Final)

 http://www.andrewjanowczyk.com/installing-caffe-on-the-ohio-super-computing-osc-ruby-cluster/ 

## Testing Installation

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
net_weights = os.path.join("models/bvlc_reference_caffenet/", 'bvlc_reference_caffenet.caffemodel')
net_definition = os.path.join("models/bvlc_reference_caffenet/", 'deploy.prototxt')
net = caffe.Net(net_definition, caffe.TEST, weights=net_weights)

net.blobs['data'].data[...] = 1
net.forward(end='fc6')
```

Test GPU installation 

[Berkeley Model zoo](http://caffe.berkeleyvision.org/model_zoo.html )