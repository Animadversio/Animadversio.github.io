

 Li, S., Liu, N., Zhang, X. H., Zhou, D., & Cai, D. (2014). Bilinearity in spatiotemporal integration of synaptic inputs. PLoS computational biology, 10(12), e1004014.
  Spruston, N. (2008). Pyramidal neurons: dendritic structure and synaptic integration. Nature Reviews Neuroscience, 9(3), 206.
  Mel, B. W. (1993). Synaptic integration in an excitable dendritic tree. Journal of neurophysiology, 70(3), 1086-1101.
  Magee, J. C. (2000). Dendritic integration of excitatory synaptic input. Nature Reviews Neuroscience, 1(3), 181.



# Synaptic Integration



Erik De Schutter

Nonlinear processing capability of dendrites http://www.annualreviews.org/doi/pdf/10.1146/annurev.neuro.28.061604.135703

Dendrites can carry nonlinear computation https://www.nature.com/articles/nn1253

Why Different neurons have different dendritic tree geometry? http://www.pnas.org/content/106/30/12536.full.pdf

Purkinje cell dendritic tree

## Bilinearity in spatiotemporal integration of synaptic inputs

Li, S., Liu, N., Zhang, X. H., Zhou, D., & Cai, D. (2014). Bilinearity in spatiotemporal integration of synaptic inputs. PLoS computational biology, 10(12), e1004014.

2014年NYU David Cai 上交Zhou Dongzhao Zhang Xiaohui 组一起发的文章. 和另一篇Zhang Xiaohui Mooming Poo实验文章是背靠背的一对. 

主要用Cable Equation分析了Dendritic tree上两点有synapse时 synapse活动输入的电流怎样在Soma上汇集. 



**Significance**: 

* 可以用synapse之间的两两interaction函数 来模拟整个dendritic tree活动时对soma的输入. 
* 因此可以绘制Dendritic graph, 及其随时间的变化, 即绘制每个时刻被激活的synapse之间两两的作用项. 根据这些相互作用项即可模拟出整个soma的subthreshold的Voltage变化. 

$$
V_S(t)=\sum_p V_E^p(t)+\sum_q V_I^q(t)+\sum_{ij}\kappa_{ij}(t) V_E^i(t)V_E^j(t)+\sum_{mn}\kappa_{mn} (t)V_E^m(t)V_I^n(t)+\sum_{kl}\kappa_{kl}(t) V_I^k(t)V_I^l(t)
$$



**Note**

* 进行上述计算"简化"需要分别得到每个Synapse自身激活的Voltage trace $V_E^p(t),\ V_I^p(t)$, 
* 以及得到其两两在特定的arrival time difference下的相互作用系数$\kappa_{ij}(t)$
*  



**启示:**











