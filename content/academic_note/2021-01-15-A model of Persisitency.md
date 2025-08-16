---
layout: post
title: A Model of Persistency
author: Binxu Wang
date: '2021-01-15'
comments: true
use_math: true
categories: [personal writing]
tags: [essay, personal writing, life, RL, Reinforcement Learning]
---

A Model of Persistency and Quit
=======

Last week, when I have a long philosophical + computational conversation over beers with [Kaining](), we developped these models and understanding. Broadly speaking it's about how we make sense our life with the RL framework. 

## 1 Baseline for Reward

In the field of reinforcement learning and in our life, an event can be rewarding or punishing to an agent or to us depending on a reference point, which is called the baseline. 

Think about it, getting 90/ 100 in a course can be a rewarding event for an average student, but it can be dramatically disappointing for a top student who gets 100 / 100 in any course. Similarly, in a class that generally give scores like 70+-10, getting a 90 is quite an achivement, but if the average score is aroung 90+-5, then you will not be that proud of your result. 

These examples show that the reference point or baseline can depend on many factors:

* The average or common outcome, that I've achieved before. This is the trajectory of your past. 
* The average or common outcome that others achieved. This is the ensemble of trajectory of others. 

Similar principle applies to salary, scientific achivement, intellectual gain, knowledge in some domain, artistic taste, and every action or behavior that can be rewarding. 

Note that the reference point is quite related to the Expectation of reward. We estimate these expectation based on the physical world, our action history and your past experience, which is a good choice as a reference point. 

But we don't necessarily choose expectation as baseline. We can pick lower or higher than the expectation. A lower pick can result in a larger reward prediction error, i.e. surprise in a good direction. A higher pick can result in a lower RPE, then we can be more disappointed. 

> **You can alter baseline in your mind** . 

But don't forget, you are the agent and the game and algorithm designer. You are not bound to one way of setting the baseline. You are free to set and reset baseline as anything or any function. 

* Even you've got paper published you can still believe that's your first paper, and be as happy as that's first time. 

* Even if you know you are strong, you can still be happy at overcoming yet another mountain. 
* Evern if you know you are smart, you can still be happy about getting another knowledge domain in your mind. 

* Baseline is important in learning as well! During learning, we usually get intrinsic reward only, without external reward from others (unless we are undergrad and taking classes). In that case, the baseline we set for ourselves can dramatically affect our happiness. 
  * If I think only finishing the book is rewarding, then any time before finishing it yield no reward. Then you can rush to the end without learning much. 
  * If I feel the large rewards come when I finish the whole course, then when I'm getting each lesson done I got few reward. 
  * But if I reset my baseline to be 0, then any experience and new knowledge can be rewarding. That is a good attitude to have in life. 

### 2 Effect and Purpose of Baseline 

What's the effect of a baseline? 

In the reinforcement algorithm, it's a critical component that can affect the learnt behavior. For a lower baseline, more diverse behavior can be reinforced, while for a higher baseline, only the top behavior that yield the largest reward will be strengthened. 

I feel why some people are harder to make choices between options of similar reward may be related to a higher baseline. 

Thus, the purpose of choosing a baseline is to titrate the reward / punishment to finally maximize reward and achieve the goal, which is the final goal of reinforcement learning. 

For us, the happiness or unhappiness brought by a baseline *per se* is not the final goal, it's just a reward in one step. The total reward that is brought by your policy over your whole trajectory is the final goal. You can set your baseline as anything to achieve your goal. 



## 3 Baseline and Motivation 

In real life, one major effect of baseline is on our motivation. Getting the 2nd place always can be encouraging and can be frustrating, depending on the reward baseline. 

For things that do not yield reward frequently, we are less likely to do it usually or persistently. For things that can generate frequent rewards either intinsically or externally, we are much more likely to constantly do those things, which is similar to addiction, as we reinforce ourselves on these actions. 

Similarly, when we set too high a baseline for us, then sometimes, we failed too often and get disappointed too often to the point that we do not want to do that thing anymore. 



## 4 Expected Outcome and Motivation

We are constantly and implicitly estimating the expected "reward" by doing sth. in the future. This expected outcome will dramatically affect the decision of us quit or persist. 

Take some physical skills as example. If I've never skiied before, and I've not done anything similar to it. Then at first I have no expectation of how good I will do. After I take a first try, I get some initial data then I can project the data point and get an expectation of my future outcome. 

If I get negative results too often, I will get the impression that I cannot do this well. And the expected reward in the future is negative, thus I should quit. But as long as I constantly get some reward, I will not quit and I'll happily continue doing it. 



Thus, keep the interest and motivation is very important. If you set too high a target AND too high baseline, then you will feel the punishment through out the trial. And you would like to quit sooner. 

However if you have a lower baseline and then keep getting the reward, you may get far more by doing something constantly. 

So reward frequently by treating yourself better! 

## 5 Happiness and Altruism

What is altruism? What does it mean to make the world better? 

Does that translate to increase the happiness of the whole world?

Then it relates back to the question of what is reward or utility. 

If that's the case, then it's maximizing the utility summed or averaged over the whole population. However, these utility functions are custom to each person. Different persons like different things and can feel happy or sad about the same thing. Sample the utility function of the population is hard. You can know that from the election in 2020. 

How can you maximize summed utility function? 


$$
\arg\max_s \sum_{i\in P} U_i(s)\approx \sum_{i\in \tilde P} 
$$


In another way, you can have an ideal utility function (value function), which is derived from principles or books. This function doesn't de

It can be environmentalism, nationalism, equality, freedom of speech. 

These are just functions of state 

Thus instead of using the utility function of real persons, we can use this idealized utility function, which simlify the problem greatly. 



