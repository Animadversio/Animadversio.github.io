---
layout: post
title: Automatic Behavioral Quantification Pipeline 
author: Binxu Wang
date: 2018-11-17
comments: true
categories: [Neuroscience, machine learning]
tags: [tech note, Image Analysis, Machine Learning, Behavior]
---

## How to automatically analyze behavior video? 

[`DeepLabCut`](https://github.com/AlexEMG/DeepLabCut) is a powerful tool to rapidly[^0] train a neural network (based on ResNet) to track keypoints on movement videos, esp. those of moving human or animals. Thus this is a game changing tool for all kind of behavior quantification for neuroscience and psychology researchers (can be applied to nearly any behavioral science topic, e.g. motor learning, motor control, facial expression, social interaction...). The workflow is relatively simple and it scarcely takes time after the network have been trained, and the video analysis can be done automatically. Because of this it's really favorable to the reserchers doing long term ecological video recording. 

However, several persisitant GUI bug in this module drives me to find a workaround of that, which result in the pipeline in this technical post. 

[^0]: It is REALLY FAST! The first time I trained a network to track facial keypoints, it was all within half an afternoon. 

## Problem: Highly unstable GUI of `DeepLabCut` 
I've installed `DeepLabCut` 2.0 on Windows 10 (with GPU) and Ubuntu environment. In both setting I faced quite serious GUI crash problem, which means there are thousands of ways that you can click the wrong button / in the wrong order / drag the slide bar too fast / in the retrograde direction, which can cause the GUI breakdown, and in many cases the python kernel crash togetherwith. However, if there is no GUI involved, the `DeepLabCut` works really well! Building up and training deepnetwork (using GPU), analyzing, annotating and exporting video work smoothly and coherently. [^1] This bug is driving me mad, as it could crash and destroy the unsaved dataset (the most labor costing part of this pipeline) you are making when doing annotation. This is unacceptable for a smooth workflow. 

Certainly, the GUI is inevitable in the frame selection and keypoint annotation processes. But I notice that the `DeepLabCut` module only requires input from the bunch of frames/images and data table files, `CollectedData_xxx.csv` and `CollectedData_xxx.h5`. Thus I get the idea that I can use some more robust and common software with GUI to annotate and save the keypoints' coordinates, and covert that into the formats (`.csv`,`.h5`) that `DeepLabCut` requires to construct its training dataset. This is the motivation of this project. 

[^1]: I've looked for solutions for this problem. The cause of the bug may  root in the complex interaction of GUI, C++ system and the python modules. I cannot find a solution to that online, maybe this is a unique problem of my computer setting. Or maybe it's just an unsolved bug of the module, as it's fairly new. 

## Tools

As I usually do, I try to combine several pre-established tools with respective advantages and build the interface between them to make them function concertedly. 

**Tools**

* [`DeepLabCut`](https://github.com/AlexEMG/DeepLabCut): the recent game changing breakthrough, which is the major player of this pipeline. 
* [`ImageJ`](https://imagej.nih.gov/ij/download.html): traditional image analysis software for scientific image analysis. It has pretty robust and easy to use GUI and lots of plugins. It can transform the `.avi` movie into frame sequences in many formats, and can also take screenshots and save as image files. Thus, it's suitable for **Frame Extraction**
    * [`Point Picker`](http://bigwww.epfl.ch/thevenaz/pointpicker/):  An ImageJ plugin developped by EPFL scientists which can pick up to 1024 points [^2] in an image, and can deal with image sequence well. Thus it's suitable to **Label Frames** 
* [Interface (data format transforming) script](https://github.com/Animadversio/KeyPointDataPreprocess4DeepLabCut/blob/master/PointPickerDataTransform.ipynb): (The only part I write) Transform the output file of `Point Picker` to the required formats of `deeplabcut.create_training_dataset(.)`. 
    * [`Pandas`](https://pandas.pydata.org/pandas-docs/stable/): `DataFrame` in `Pandas` is the intermediate data structure I used to do the transformation. 

![ImageJ Output]({{ site.baseurl }}/assets/img/posts/ImageJ_DeepLabCut/ImageJ PointPicker Output.png)

## Workflow combining `ImageJ` and `DeepLabCut`
Here is the complete workflow / protocol we can follow when starting a behavioral quantification project. 

* **Video recording**
* Create a project in `DeepLabCut`: 
    - `config_path =deeplabcut.create_new_project('Name of the project','Name of the experimenter', ['Full path of video 1','Full path of video2'], working_directory='Full path of the working directory',copy_videos=True/False)`
* **Frame Extraction**: 
    - We can use the automatic extraction tool in `deeplabcut` as baseline: `deeplabcut.extract_frames(config_path,'automatic','kmeans', crop=True, checkcropping=True)` (which is relatively robust)
    * And then, supplement it with manual selection from `ImageJ` 
    * Open the video with `ImageJ`. Slide and select the key frames and saveas `png` files in `ImageJ`
    * Note the training set can consist of frames of different size, cropped and uncropped mixed together. 
* **Label the Frames**:
    - We can use the GUI tool in `deeplabcut.label_frames(config_path)`
    - Or
    - Use the ImageJ, `Point Picker` plugin
        + `Import>Image Sequence` select the folder of the extracted frames
        + Open `Point Picker` and mark the key points in sequence from the first image. 
        + Export the coordinates data with `Import/Export` tool. save the `data.txt` file
    - Convert the `txt` date into `csv` and `hdf5`
* **Check the annotation**: 
    - `deeplabcut.check_labels(config_path)`
* **Create Dataset**: 
    - `deeplabcut.create_training_dataset(config_path,num_shuffles=1)`
* **Train Network**: 
    - `deeplabcut.train_network(config_path,shuffle=1)`
* **Evaluate Network**: See the training loss and test loss
    - `deeplabcut.evaluate_network(config_path,shuffle=[1], plotting=True)`
* **Video Analysis**: 
``` python
deeplabcut.analyze_videos(config_path,['/analysis/project/videos/reachingvideo1.avi'], shuffle=1, save_as_csv=True)
deeplabcut.create_labeled_video(config_path ['/analysis/project/videos/reachingvideo1.avi','/analysis/project/videos/reachingvideo2.avi'])
deeplabcut.plot_trajectories(config_path,['/analysis/project/videos/reachingvideo1.avi'])
```

And Voila! Here is the tracking result: [Tracking result](https://github.com/Animadversio/KeyPointDataPreprocess4DeepLabCut/blob/master/TrackedFaceClip.gif)


## Drawback
Smooth as it may seem, there is an drawback of this annotation workflow. The annotation function is not exactly equivalent to the native `DeepLabCut` one. Note, in original `DeepLabCut` module, it's allowed to miss some label in a frame, as **occlusion** happens sometime. But it's harder to do so in `ImageJ` setting. 

This is a major direction that I'd like to improve if I'd heavily lean on this pipeline. 


## Appendix: Solution Process and Reference
(This part is a collection of references that I checked in this process. )

Major dataframe I/O lines in [`DeepLabCut` module](https://github.com/AlexEMG/DeepLabCut/blob/master/deeplabcut/generate_training_dataset/labeling_toolbox.py) 
```python
self.oldDF = pd.read_hdf(os.path.join(self.dir,'CollectedData_'+self.scorer+'.h5'),'df_with_missing')

self.dataFrame.to_csv(os.path.join(self.dir,"CollectedData_" + self.scorer + ".csv"))
self.dataFrame.to_hdf(os.path.join(self.dir,"CollectedData_" + self.scorer + '.h5'),'df_with_missing',format='table', mode='w')
```

Reference for Pandas data table construction

* [MultiIndexing Format](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.MultiIndex.html)
* [Indexing](https://pandas.pydata.org/pandas-docs/stable/indexing.html)
* [Data I/O](https://pandas.pydata.org/pandas-docs/stable/io.html#csv-text-files)

[YAML Parser in Python](https://stackoverflow.com/questions/1773805/how-can-i-parse-a-yaml-file-in-python)

Details at my github repertoire [KeyPointDataPreprocess4DeepLabCut](https://github.com/Animadversio/KeyPointDataPreprocess4DeepLabCut). 




