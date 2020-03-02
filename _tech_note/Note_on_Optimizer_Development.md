# Optimizer Development for Online Neural Activity Maximization

## Motivation



## Background 

Here, I state a few technical constraints on Optimizer Development, and our way to tackle it. 

* **Zeroth Order** (Derivative Free): 
* **Limited evaluation number**: 
* **Neural variability**: For sensory cortices, same stimuli can elicit different response in different presentation. 
* **High dimensionality of stimuli space**: For visual world and auditory world, the dimensionality for natural inputs are high. 
* **Geometry and topology of the stimuli space**: 



## Methodology

Many of the existing work on online neural activity optimization are using **Genetic Algorithm**, which is a classic evolutionary algorithm. As all evolution algorithm has these components 

* **Mutation**: Generate new samples that differs from each other and to ancestors to send into fitness function. 
* **Selection**: Use the fitness score to offspring, 

But Genetic Algorithm also built in the assumptions that the genes have nearly additive effect on the resulting phenotypes and scores, which is not the best approximation for image generators like GAN, which has a complex intrinsic manifold of images. 

We are trying to develop some better optimization methods that suits our specific application, and try to gain insight about the general principle underlying optmizer design for this purpose. 

To carry on the metaphor, evolution strategy type algorithm relies on two principles 

* **Diversity**: The diversity within each offspring generation should be large enough (in the sense of the **scoring function**), such that a meaningful selection could happen and guide the change of population. 
* **Heredity**: The children's generation should bear resemblance to their ancestor (in the sense of the **scoring function**), such that the beneficial features could retain and accumulate throughout evolution. 

These requirements seem trivial, but in fact, they can enforce a strong constraints on the way we do sampling. When combining with other factors in our application, the stimuli space and it's geometry. 



## CMA-ES

Observing the success and improvement of CMA-ES, we want to distill down some of its principles and modify the algorithm to improve it. 

**Step Computation Strategy** : Rank based computation vs Raw score based computation. 

**Exploration Strategy** : 

On the other hand, there are some mechanisms in CMA-ES that break down in high dimension. 

* Covariance matrix update mechanism: 
* Step size $\sigma$ tuning mechanism: in the original paper, 

### Feature Diversity in Current GAN space. 





## Spherical and Cylindrical Exploration Optimizer

