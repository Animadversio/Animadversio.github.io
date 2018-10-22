Visual Cortex Models
===========
http://www.scholarpedia.org/article/Models_of_visual_cortex

[TOC]



## Philosophy

* Why do we build model? What do we want to explain/predict/explore?
* How do we build it? 

### Bottom up vs top down

* Bottom-up
  * Biophysical perspective
  * Neural model
  * Spiking Neuron
    - Point neuron model
    - Multicompartment model
  * Non-Spiking Neuron (may also used in top down model)
    - "Rate code"
    - Need long time average (~100ms)
    - Or small population average (~10ms) == Multi trial average
* Top-down
  * Cognitive Science, CS, AI perspective
  * **Normative Approach**: Explain the Vision based on optimality; Ideal operation instead of detailed computation
    * Visual statistics
    * Sparse coding
    * Bayesian inference model of vision

### Model Target

* **Circuit model of operations**: Hardware and algorithm
  * gain control
  * normalization
* **Models of visual functions**: Function
  * motion computation 
  * object recognition
  * Depth perception



**Biological plausibility**

## Basic operation model

**Huber-Wiesel model:**

Hubel, D.H. & T.N. Wiesel (1962). Receptive fields, binocular interaction and functional architecture in the cat’s visual cortex. *J Physiol* 160:106–154.

* Orientation selectivity comes from selectively pooling LGN center-surround RF
* ​





Douglas, R.J. & K.A. Martin (1991). A functional microcircuit for cat visual cortex. *J Physiol* (Lond) 440:735–69.



## Function model

### Early Vision

**Orientation Tuning**

* Huber Wiesel: Input geometry
* Recurrent Circuit Shaping selectivity
* Feedforward for Simple cell
* Recurrent for Complex cells

**Early Visual Processing Model** 

* edge detection [(Marr 1979)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Marr1979), 
* spatio-temporal interpolation and approximation, 
* computation of optical flow and direction selectivity [(Ullman 1979](http://www.scholarpedia.org/article/Models_of_visual_cortex#Ullman1979); [Marr 1981)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Marr1981), 
* **Stereo Vision**: computation of lightness and albedo, shape from contours, shape from texture, shape from shading, binocular stereo matching [(Marr & Poggio 1976)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Marr1976), 
* structure from motion, structure from stereo, surface reconstruction [(Grimson 1982)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Grimson1982) and filling-in [(Ullman 1976)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Ullman1976), 
* computation of surface color [(Barrow & Tenebaum 1981](http://www.scholarpedia.org/article/Models_of_visual_cortex#Barrow1981); [Marr 1982](http://www.scholarpedia.org/article/Models_of_visual_cortex#Marr1982); [Hurlbert 1989)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Hurlbert1989) 



**Motion vision**

* MT Cells model
* [(Rust, Mante et al. 2006)](http://www.scholarpedia.org/article/Models_of_visual_cortex#Rust2006) 线性加和, Relu, Normalization. 用于拟合MT Neuron的firing rate

### Recognition

**Invariance?**

* Q: 同样的客体/脸 在进入视觉系统时有着很不同的位置, 大小, 但最后到达IT neuron客体识别区域 firing是一致的! 
* Feedforward Hierarchical model (Like CNN)
  * 通过从简单的feature提取, 逐渐整合 pooling 最后得到越发invariant的模型. 
  * Omit multiple fixations, top-down signals, attentional effects…

【大部分Model都是在Fit一个Area的反应, 很少有考虑两个以上Area反应的模型. 现在有人开始做了



**Face Processing**



## Top-Down projection

* Bayesian
  * feedforward observation and feedback prediction (*prior*) to verify
* Modulating feedforward connections
  * Route/ Gating / Gain control
  * Attention — spotlight model
  * Routine/program selection 现在执行什么视觉功能, 阅读 还是看风景 还是寻找什么. 

Use CNN to faithfully reproduce result? 



## Feedforward, Feedback and Predictive Coding

David Heeger: Heeger, D. J. (2017). **Theory of cortical function**. Proceedings of the National Academy of Sciences, 114(8), 1773-1782.

* Use an optimization function to derive 
* the prior for each units' activity is quite artificial, which we do not know where it comes from 
* ​









