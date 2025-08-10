---
layout: post
title: Using Google Cloud Service for Large Scale Image Labelling
author: Binxu Wang
date: 2019-09-11
comments: true
categories: [machine learning]
tags: [tech note, Image Analysis, Machine Learning, Computer Vision]
---

# Using Google Cloud Service for Large Scale Image Labelling



## Installing Google SDK 

https://cloud.google.com/sdk/docs/quickstart-windows

1. New a Google Cloud Platform Project
2. Download [Google Cloud SDK](https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe?hl=zh-cn)
   1. After installation run `gcloud init` and log in to your account there! 
   2. Select the GCP Project and the computing zone
   3. Finish the SDK configuration!



## Installing Google API for different programs (like Vision we use)

https://cloud.google.com/python/

https://googleapis.github.io/google-cloud-python/latest/vision/index.html

`conda install -c conda-forge google-cloud-vision `

Following packages may be necassary

`conda install -c conda-forge google-api-python-client `

`conda install -c conda-forge google-auth` 

`conda install -c conda-forge google-auth-oauthlib` 

## Set up Credentials for Google on PC

https://cloud.google.com/docs/authentication/getting-started

1. Follow the steps to get an account and a credential. Download the JSON file it generates 
2. `export` or set the environment variables manually
   1. `set GOOGLE_APPLICATION_CREDENTIALS=[path_to_json]`

*Note*: If this is not set, then you can import the google packages like `from google.cloud import vision`. But you will see errors when creating a client! 

https://cloud.google.com/docs/authentication/production#obtaining_and_providing_service_account_credentials_manually



*Note*: If the environment variable is not working, manually set it in python. 

```python
import os
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r"D:\Github\Google_Vision_Image_Labelling\Image-patch-labelling-4e4cfd1664c2.json"
```

## Use the service through the client! 

```python
import os
import io
import json
import pickle
from os.path import join
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r"D:\Github\Google_Vision_Image_Labelling\Image-patch-labelling-4e4cfd1664c2.json"
# set up the client
from google.cloud import vision
client = vision.ImageAnnotatorClient()
#%%
imgbasedir = r"N:\Stimuli\2019-Free-Viewing"
subfolders = ['2019-08-19-Beto',
]
for subfolder in subfolders:
    imgdir = join(imgbasedir, subfolder)
    # filter image names by their suffix
    imgnames = [fn for fn in os.listdir(imgdir) if \
                any(fn.endswith('.'+sfx) for sfx in ["bmp","BMP","jpg","jpeg","png","JPG","JPEG","tiff","TIFF"]) and \
                not os.path.isdir(join(imgdir, fn))]
    print("%d Images in %s folder" % (len(imgnames), subfolder))

#%%
from time import time
t0 = time()
for subfolder in subfolders:
    imgdir = join(imgbasedir, subfolder)
    # filter image names by their suffix
    imgnames = [fn for fn in os.listdir(imgdir) if \
                any(fn.endswith('.'+sfx) for sfx in ["bmp","BMP","jpg","jpeg","png","JPG","JPEG","tiff","TIFF"]) and \
                not os.path.isdir(join(imgdir, fn))]
    print("%d Images in %s folder" % (len(imgnames), subfolder))

    image_parse_dict = {}
    for imgname in imgnames:
        with io.open(join(imgdir, imgname), 'rb') as image_file:
            content = image_file.read()
        print(imgname)
        image = vision.types.Image(content=content)

        response = client.label_detection(image=image)
        labels = response.label_annotations
        print('Labels:')

        label_data = []
        for label in labels:
            print("%s score: %.4f " % (label.description, label.score))
            label_data.append((label.description, label.score))
        print("\n")
        image_parse_dict[imgname] = label_data

    pickle.dump(image_parse_dict, open(join(imgdir, "label_dict.pkl"), "wb")) # Pkl file saved in binary format
    json.dump(image_parse_dict, open(join(imgdir, 'label_result.json'), 'w')) # json file saved in readable format
    print("%.1fs" % (time() - t0))
    # JSON is easier for matlab to read!!
    # do `jsonData = jsondecode(fileread('..\\label_result.json'));` in matlab

print("%.1fs" % (time() - t0))
#%% Loading code post hoc
image_parse_dict = pickle.load(open(os.path.join(imgdir, "label_dict.pkl"), "rb"))
data_dict = json.load(open('result.json', 'r'))
```



