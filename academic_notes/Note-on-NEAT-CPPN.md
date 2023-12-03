https://towardsdatascience.com/understanding-compositional-pattern-producing-networks-810f6bef1b88

## CPPN

Images or sound could be thought of as a continuous function over space, $I[x,y]$.  As such this function could be modelled by a neural network! 

The basic idea of CPPN is simple, it's just input $x,y$ coordinates as input to a neural network and output patterns. Thus, this idea is quite general: Regress images or voxels or sequence onto the underlying spatial / temporal grid (e.g. `meshgrid`).  

As such, CPPN could be thought of as a image parametrization using neural network. Different from GAN, the parameters are the weight and network architectures, while the input is fixed x,y grid. 

If we fixed the network architecture of CPPN, then this model could be simply optimized by a modern DL framework, i.e. by autograd your loss function onto the weight in between. 

For example, here is a pytorch implementation of cppn, It's just using 2 kinds of non-conventional acitivation function. Interleave this activation function with convolution. 

```python
from collections import OrderedDict
import torch
import numpy as np

class CompositeActivation(torch.nn.Module):
    def forward(self, x):
        x = torch.atan(x)
        return torch.cat([x/0.67, (x*x)/0.6], 1)

def cppn(size, num_output_channels=3, num_hidden_channels=24, num_layers=8,
         activation_fn=CompositeActivation, normalize=False):

    r = 3 ** 0.5
    coord_range = torch.linspace(-r, r, size)
    x = coord_range.view(-1, 1).repeat(1, coord_range.size(0))
    y = coord_range.view(1, -1).repeat(coord_range.size(0), 1)

    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

    input_tensor = torch.stack([x, y], dim=0).unsqueeze(0).to(device)

    layers = []
    kernel_size = 1
    for i in range(num_layers):
        out_c = num_hidden_channels
        in_c = out_c * 2 # * 2 for composite activation
        if i == 0:
            in_c = 2
        if i == num_layers - 1:
            out_c = num_output_channels
        layers.append(('conv{}'.format(i), torch.nn.Conv2d(in_c, out_c, kernel_size)))
        if normalize:
            layers.append(('norm{}'.format(i), torch.nn.InstanceNorm2d(out_c)))
        if i < num_layers - 1:
            layers.append(('actv{}'.format(i), activation_fn()))
        else:
            layers.append(('output', torch.nn.Sigmoid()))

    # Initialize model
    net = torch.nn.Sequential(OrderedDict(layers)).to(device)
    # Initialize weights
    def weights_init(module):
        if isinstance(module, torch.nn.Conv2d):
            torch.nn.init.normal_(module.weight, 0, np.sqrt(1/module.in_channels))
            if module.bias is not None:
                torch.nn.init.zeros_(module.bias)
    net.apply(weights_init)
    # Set last conv2d layer's weights to 0
    torch.nn.init.zeros_(dict(net.named_children())['conv{}'.format(num_layers - 1)].weight)
    return net.parameters(), lambda: net(input_tensor)
```

Besides, CPPN could be used in line with GAN to provide even better result. 

https://github.com/rystylee/pytorch-cppn-gan

## NEAT

From the introduction above, we know CPPN could be used independent of NEAT, i.e. fix the topology but learn the weight by backpropagation or non-gradient optimization. 

However, when NEAT comes into play this becomes much more powerful. 

In its essence NEAT is to optimize neural network graph structure and weight together. It's hard to optimize topology by gradient, so it's natural to use gradient free algorithms like GA for topology. 

Thus, the only technical issue will be how to encode the neural network topology as a linear gene and how to mutate or augment it. 







## Issue

One Issue that CPPN images have is they are usually overly smooth to be natural images. Probably the high frequency edges are harder to generate through CPPN. Because of this I cannot think it as a perfect model of natural images as GAN do. 

