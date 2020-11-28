---
layout: post
title: Note on MinMax Game
author: Binxu Wang
date: May 18th, 2020 (updated Oct.13th)
comments: true
use_math: true
categories: [machine learning, algorithm, computer science]
tags: [academic note, reinforcment learning, machine learning, AI, deep learning]
typora-copy-images-to: ../assets/img/notes/RL/
---

# Note on MiniMax (Updating)

## Motivation

This is a very traditional way of solving turn based game like chess or tic-tac-toc. It's climax is Deep Blue AI in playing chess. 

Note, some people think about GAN training procedure as a min-max game between G and D, which is also interesting. 

So the setting is you have 2 parties with conflicting objective $L_A=-L_B$    . One side wants to minimize this value, the other side wants to maximize this value to win. 

* In Chess it can be the value of all pawns summed, or a more complex evaluation of how a scenario favors black > white.
* In GAN, it's the similarity or discriminability of the 2 distributions. G wants to minimize discriminability, D wants to maximize discriminability. 

## MinMax





## Alpha-Beta Prune

