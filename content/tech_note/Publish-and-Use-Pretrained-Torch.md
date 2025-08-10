---
layout: post
title: Publishing and Using Pretrained model through `Torch.hub`
author: Binxu Wang
date: June 3rd, 2020
comments: true
use_math: true
categories: [machine learning, coding]
tags: [machine learning, reproducibility, productivity]
typora-copy-images-to: ../assets/img/notes/cv/
---

# Motivation

This is a simple example. 

https://github.com/ProGamerGov/pytorch-old-tensorflow-models

```python
if pretrained:
	self.load_state_dict(torch.hub.load_state_dict_from_url(model_urls['inceptionv1'], progress=progress))
```

The official blog about how to use this is [here](https://pytorch.org/blog/towards-reproducible-research-with-pytorch-hub/). 

## Hosting Weights

The major challenge is to publish weight online. For that you need a `public file hosting` service, which Google Drive and OneDrive can do. 

The second thing is you need to have a link directly to the file instead of to the webpage. For that you can search direct download link. 

Currently my solution is, 

* OneDrive business doesn't seem to have the **embed** option so doesn't work
* Google Drive cannot share large file directly, though you can download them through links. 
  * Use this [website](https://sites.google.com/site/gdocs2direct/) to turn the shareable link into a direct downloadable link. But it's not directly downloadable for large files.
* So I use OneDrive personal for this, 
  1. Put the files in the drive
  2. View the file online. 
  3. Select the option `Embed` in right click menu. 
  4. Copy the embed code to [this website](http://metadataconsulting.blogspot.com/2014/05/how-to-get-direct-download-link-from.html) and follow the 3 steps. 
  5. Then you can get the Direct Download Link and put them in your code. 

After hosting the weights 

`self.load_state_dict(torch.hub.load_state_dict_from_url(model_urls['inceptionv1'], progress=progress))` will work perfectly! 

## Loading Weights

To avoid downloading weight multiple times, we can make a local cache system like this.  

```python
def load_statedict_from_online(name="fc6"):
    torchhome = torch.hub._get_torch_home()
    ckpthome = join(torchhome, "checkpoints")
    os.makedirs(ckpthome, exist_ok=True)
    filepath = join(ckpthome, "upconvGAN_%s.pt"%name)
    if os.path.exists(filepath):
        torch.hub.download_url_to_file(model_urls[name], filepath, hash_prefix=None, progress=True)
    SD = torch.load(filepath)
    return SD
```

A more advanced cache system could host a dict or list in the global scope in the module. So if the model has been loaded once it can be loaded from memory directly. 

