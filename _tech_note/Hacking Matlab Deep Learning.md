* TOC
{:toc}
# Hacking the Matlab DeepLearning system

[Why should I choose matlab deeplearning toobox](https://www.mathworks.com/matlabcentral/answers/421259-why-should-i-choose-matlab-deep-learning-toolbox-over-other-opensource-frameworks-like-caffe-onnx)

## Write our own layers 

[Official Tutorial](https://www.mathworks.com/help/deeplearning/ug/define-custom-deep-learning-layer.html)

```matlab
classdef myLayer < nnet.layer.Layer

    properties
        % (Optional) Layer properties.

        % Layer properties go here.
    end

    properties (Learnable)
        % (Optional) Layer learnable parameters.

        % Layer learnable parameters go here.
    end
    
    methods
        function layer = myLayer()
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            % Layer constructor function goes here.
        end
        
        function [Z1, …, Zm] = predict(layer, X1, …, Xn)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer       - Layer to forward propagate through
            %         X1, ..., Xn - Input data
            % Outputs:
            %         Z1, ..., Zm - Outputs of layer forward function
            
            % Layer forward function for prediction goes here.
        end

        function [Z1, …, Zm, memory] = forward(layer, X1, …, Xn)
            % (Optional) Forward input data through the layer at training
            % time and output the result and a memory value.
            %
            % Inputs:
            %         layer       - Layer to forward propagate through
            %         X1, ..., Xn - Input data
            % Outputs:
            %         Z1, ..., Zm - Outputs of layer forward function
            %         memory      - Memory value for custom backward propagation

            % Layer forward function for training goes here.
        end

        function [dLdX1, …, dLdXn, dLdW1, …, dLdWk] = ...
                backward(layer, X1, …, Xn, Z1, …, Zm, dLdZ1, …, dLdZm, memory)
            % (Optional) Backward propagate the derivative of the loss  
            % function through the layer.
            %
            % Inputs:
            %         layer             - Layer to backward propagate through
            %         X1, ..., Xn       - Input data
            %         Z1, ..., Zm       - Outputs of layer forward function            
            %         dLdZ1, ..., dLdZm - Gradients propagated from the next layers
            %         memory            - Memory value from forward function
            % Outputs:
            %         dLdX1, ..., dLdXn - Derivatives of the loss with respect to the
            %                             inputs
            %         dLdW1, ..., dLdWk - Derivatives of the loss with respect to each
            %                             learnable parameter
            
            % Layer backward function goes here.
        end
    end
end
```



Note if the operation has explicit `dlarray` support you don't have to write backward for it. 

https://www.mathworks.com/help/deeplearning/ug/list-of-functions-with-dlarray-support.html



## Build GAN

**Note** reshape is not supported officially so we have to add it for ourselves. 

[Official Way to work GAN](https://www.mathworks.com/help/deeplearning/examples/train-generative-adversarial-network.html) 

```matlab
layersGenerator = [
    imageInputLayer([1 1 numLatentInputs],'Normalization','none','Name','in')
    transposedConv2dLayer(filterSize,8*numFilters,'Name','tconv1')
    batchNormalizationLayer('Name','bn1')
    reluLayer('Name','relu1')
    transposedConv2dLayer(filterSize,4*numFilters,'Stride',2,'Cropping',1,'Name','tconv2')
    batchNormalizationLayer('Name','bn2')
    reluLayer('Name','relu2')
    transposedConv2dLayer(filterSize,2*numFilters,'Stride',2,'Cropping',1,'Name','tconv3')
    batchNormalizationLayer('Name','bn3')
    reluLayer('Name','relu3')
    transposedConv2dLayer(filterSize,numFilters,'Stride',2,'Cropping',1,'Name','tconv4')
    batchNormalizationLayer('Name','bn4')
    reluLayer('Name','relu4')
    transposedConv2dLayer(filterSize,3,'Stride',2,'Cropping',1,'Name','tconv5')
    tanhLayer('Name','tanh')];

```

Note there is no official output layer for image (except pixel classification layer). So this will not be a valid `SerialNetwork` However you can train it in this hacky way! 

Probably you can use regression layer to output image! 



[GAN discussion](https://www.mathworks.com/matlabcentral/answers/410141-how-to-fulfill-gan-generative-adversarial-networks-or-dcgan-in-matlab) People always know TF and PyTorch is easier than matlab to implement this thing .

[I've given up the code and you may try it in tensorflow](https://github.com/layumi/2016_GAN_Matlab#i-have-give-up-this-code-you-may-try-the-code-in-tensorflow) 

Reshape layer is not officially supported in GAN....

Caffe Doc https://github.com/BVLC/caffe/blob/master/docs/tutorial/layers/reshape.md

## Import Network Architecture from Caffe or other Framework 

This is the official solution for importation from `Caffe`

```matlab
GANpath = "D:\Generator_DB_Windows\nets\upconv\fc6";
protofile = fullfile(GANpath, 'generator.prototxt');
datafile = fullfile(GANpath, 'generator.caffemodel');
GAN = importCaffeNetwork(protofile, datafile, 'InputSize', [1, 1, 4096]);
```

## Convention Difference

https://caffe.berkeleyvision.org/tutorial/interfaces.html

> **Be aware that since Matlab is 1-indexed and column-major, the usual 4 blob dimensions in Matlab are `[width, height, channels, num]`, and `width` is the fastest dimension. Also be aware that images are in BGR channels.** Also, Caffe uses single-precision float data. If your data is not single, `set_data` will automatically convert it to single.

Note the `width, height` order difference! so may have to 

## Deconvolution Layer

[Matlab TransposedCon2](https://www.mathworks.com/help/deeplearning/ref/transposedconv2dlayer.html)

[Caffe Deconv](https://caffe.berkeleyvision.org/tutorial/layers/deconvolution.html) 

In the caffe deconvolution engine it has the properties

```protobuf
layer {
  name: "deconv5"           
  type: "Deconvolution"
  bottom: "reshape_defc5"
  top: "deconv5"
  param {
    lr_mult: 1
    decay_mult: 0
  }
  param {
    lr_mult: 0
    decay_mult: 0
  }
  convolution_param {
    num_output: 256
    pad: 1
    kernel_size: 4
    stride: 2
    engine: CAFFE
  }
}
```

But in matlab a deconvolution layer has property 

```matlab
Name: 'deconv5'

   Hyperparameters
      FilterSize: [4 4]
     NumChannels: 256
      NumFilters: 256
          Stride: [2 2]
    CroppingMode: 'manual'
    CroppingSize: [1 1 1 1]

   Learnable Parameters
         Weights: [4×4×256×256 single]
            Bias: [1×1×256 single]
```

So how does the 2 translate into each other? 

As `caffe` actually computes deconv by using the backward of conv layer as forward, using forward of conv layer as backward. (see CPP code. ) The padding means the padding in the conv part. 

For difference in conv layer and deconv layers, see https://arxiv.org/ftp/arxiv/papers/1609/1609.07009.pdf



## Other solutions

Just use half the network and concatenate them, which worked! 

