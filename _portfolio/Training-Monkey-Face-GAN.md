---
layout: post
title: Training GAN to Model Monkey Face Space
img: ..\assets\img\portfolio\monkeyfaces.png
# feature-img: "assets/img/pexels/Skysphere_Aitoff.jpg"
author: Binxu Wang
use_math: true
published: true
comments: true
date: June 9th, 2021
tags: [Macaque, Generative Model, GAN, Manifold, ML]
excerpt_separator: <!--more-->
---

# Training GAN to Model Monkey Face Space

## Motivation

Obtaining a high quality GAN for a specific domain of interest to monkeys is useful for experiments in lab. 

For training a monkey face GAN, there are a few related challenges:

1. **Data problem**: Obtaining images of monkey faces or bodies

2. **Model problem**: An efficient training method for making GAN work for a small dataset. 
<!--more-->

## DataSets

- https://figshare.com/articles/dataset/Macaque_Faces/9862586
  - Really high quality, 73 individual monkeys varying in age, 4000 images. 
  - With naturalistic background. 
  - Well formatted labels for each image in csv. 
- https://visiome.neuroinf.jp/database/list/6948
  - 20 individuals, 465 images in total
  - No background, png, easy to add fake background or rotation to do augmentation.

A more general way of obtaining these images is to scrape from Youtube video frames, but it needs to be annotated and face needs to be detected and aligned. The tools will be linked if found in the future. 

* [Python Youtube downloader](https://towardsdatascience.com/build-a-youtube-downloader-with-python-8ef2e6915d97) blog. using this [package](https://github.com/pytube/pytube) 
* Face detector 

One useful code snippet to unzip data is the [following](https://stackoverflow.com/questions/31346790/unzip-all-zipped-files-in-a-folder-to-that-same-folder-using-python-2-7-5) . 

```python
import os, zipfile
dir_name = 'C:\\SomeDirectory'
extension = ".zip"
os.chdir(dir_name) # change directory from working dir to dir with files
for item in os.listdir(dir_name): # loop through items in dir
    if item.endswith(extension): # check for ".zip" extension
        file_name = os.path.abspath(item) # get full path of files
        zip_ref = zipfile.ZipFile(file_name) # create zipfile object
        zip_ref.extractall(dir_name) # extract file to dir
        zip_ref.close() # close file
        # os.remove(file_name) # delete zipped file
```

## Face Detection and Alignment

GANs perform the best if your images are better aligned. Esp. if we are trying to model fine details of faces, the face are better aligned (rotated) and resized spatially. [See this Kaggle image example](https://www.kaggle.com/arnaud58/ffhq-flickr-faces-align-crop-and-segment). Moreover, for efficient training, we need to set a resolution of square image and then resize and crop the target to this size to really train. 

![](https://raw.githubusercontent.com/minivision-ai/photo2cartoon/master/images/data_process.jpg) 

FFHQ seems to use method in `dlib` ([see this code](https://gist.github.com/lzhbrian/bde87ab23b499dd02ba4f588258f57d5)) to align face based on keypoints. So we may try to use a similar method to find keypoints for monkey faces and then align them. 

[This post](https://towardsdatascience.com/face-detection-models-which-to-use-and-why-d263e82c302c) compares some older model/implementations to detect faces: dlib, mtcnn, DNN in caffe. 

In this project, we use the human facial landmark model to detect and crop faces for monkeys. We are specifically using [this fantastic open source program](https://github.com/cunjian/pytorch_face_landmark) of detecting human face landmarks in `pytorch`. 

After some short debugging, their pipeline built for human face detection, landmark detection and alignment worked like a charm. Here is one example without any fine-tuning or retraining their model. 

![](..\assets\img\portfolio\Badonde-5340-170519.jpg)

The cropped and aligned version looks like this, which adjust and orientation to account for the head tilt. 

![](..\assets\img\portfolio\Badonde-5340-170519_0.png)

**Note**: some lab has trained macaque specific face detectors like [this](https://github.com/clwitham/MacaqueFaces) in matlab. But we stick to the more general pipeline here. 

Empirically, we find that applying the Human face landmark model to monkeys will result in 19.8% of the crops to be unusable, although most of these wrong crops are around eyes, or nose or hands, so it's may be caused by a different geometry in monkey face and human face. 

# GAN training

For training a GAN with not a lot of images, we chose from these recent developments

* Data efficient GAN from MIT https://github.com/mit-han-lab/data-efficient-gans
* StyleGAN2 with Limited Data from NVIDIA https://github.com/NVlabs/stylegan2-ada-pytorch
* Regularize limited data gan training from Google https://github.com/google/lecam-gan


## Training Code
We picked the DiffAugment training procedure for StyleGAN2 in [data efficient gans](https://github.com/mit-han-lab/data-efficient-gans/tree/master/DiffAugment-stylegan2-pytorch). Their repo is super well organized, training run itself is quite straight forward, no debugging needed. We used the following script .

```bash
python DiffAugment-stylegan2-pytorch\train.py --outdir=training-runs --data=$Datasets\macaque_face_aligned\fullsize_clean --gpus=1 --cfg=auto  --batch=12
```

We trained on a single NVIDIA 2060 GPU on Windows system, it takes ~ 3.5hrs to train 200 epochs. At 1000 epochs, the samples already look pretty good. So it's less than a day to do the training. 

## Results
Training curves:
![](..\assets\img\portfolio\monkeyfacegan_training.png)

Fake monkey face distribution generated in 2805 epochs, looks pretty nice! 
![](..\assets\img\portfolio\fakes002805_crop_rsz.png)


