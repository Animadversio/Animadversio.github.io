---
layout: post
title: AI for Texas Hold'em
img: ..\assets\img\portfolio\Texas_Holdem.png
# feature-img: "assets/img/pexels/Skysphere_Aitoff.jpg"
author: Binxu Wang
use_math: true
comments: true
date: Jan 2nd, 2021
tags: [Math, Probability, Artificial Intelligence, Game]
---

# AI for Texas Hold'em

## Motivation

Texas Hold'em is a game of probability and calculation. Sometimes, we feel playing it with human mind is too inefficient and learning the strategy is too slow or costly. Thus I'd like to develop an artificial intelligent system that plays the game and we human and the system can learn from each other. Human can learn to estimate the probability better and counter our biases, the system may learn how to approximate many intuitive strategy in human. By this we may find the probabilistic foundation of strategy in human players (e.g. bluffing early raising etc. ).

![Img From https://www.instructables.com/Learn-To-Play-Poker---Texas-Hold-Em-aka-Texas-Ho/](..\assets\img\portfolio\PokerRanking.png)





## Heuristics

As we played Hold'em a lot recently, some rule of thumbs could be learnt easily. 

* Usually follow when your card is weak. 
* Fold if you cannot afford to bet you can win. 
* Raise to win money if you are strong. 
* Raise gradually to lure people in. 
* All in if you are sure that you will win and the other side want's to follow. 



## Conceptualize Texas Hold'em





## Encoding

How to represent cards by numbers?

Here we follow a simple way of using a binary tuple to represent a card $$(color, num),\;color\in[1,2,3,4].\; num\in[1,...,13]$$ , which can easily be mapped to a number in the range of $$1-52$$. 



## Match Table Representation

As we think about it, there are $$C^{3}_{52}=22100$$ possible 3 card sets in 52 available cards. Given this set of public cards, there are $C_{49}^2=1176$ possible sets of private card, and the same number of possible un-revealed cards[^1]. Given this setup, we have a 1176 by 1176 (N of possible private cards by N of possible public cards) square matrix for each set of public cards.  

Note some entry of this matrix is not possible, since, the public card and the private card share the same card. As a result, $$95*1176=111720$$ entries of this matrix is forbidden. I call this matrix of unavailable matrix `CollideMat`. 

The entry of this matrix can contain different things, for example, it can contains the best (strongest) 5 card set for the $$7=3+2+2$$ cards. A step further, I can compute the ranking or percentile of each private card set given a public card set (rank within column). After this we can simply compare the ranking instead compare the five card set, thus making the following computation easier. 

Note the **full game play after public card reveal can be well described in this matrix**. 

Each revealed public card will cross out some column, for example, the 4th public card will leave only 48 columns (or less) in the matrix, 5th public card will leave only 1 column left. 

On the side of private cards, the $N$ players each occupies a unique and mutually compatible row. For each player he know his own row in this matrix, without knowing other player's row. To win the game means in the final column of public card, your row has a higher ranking / percentile than other players on table.  

[^1]: Note this is an over-estimate, since for each player his private information (2 cards he holds) informs him that some (95) combination of public cards are not possible, thus cross out some column of the matrix. 

For each game, this matrix IS the BATTLEGROUND for all the player. 

## Pre-Compute Match Table

Note the structure we detailed in the last section is not dependent on any game state or mind set of player. It's just a fixed structure inherent in the rule of games, because of this we can compute it beforehand. 

At the first glance, what we need to compute are 22100 square matrices of 1176 by 1176, correspond to match matrix of all public card combinations. 

But memory and computation-wise this is not very efficient. In my current CPU, compute one match table takes ~ 2 mins, thus all the match table will take ~ 30 CPU days. On the storage side, this can takes ~ 120 Gb to store all the tables, even though I use low precision integer number to store the ranking and collision matrix. 

In the end, I leveraged the symmetry of public card sets, i.e. 4 colors are equivalent thus many public sets are the same just by remapping the cards' color[^3]. This dramatically save computation. At the end of the day, only 1795 sets of public card (match table) needs to be computed. Then I designed a color remapping process to rename the colors to get the match table they need. 

This computation takes around half a day by distributing onto 10 CPU nodes on cluster. And the database is less than 10 Gb, which can be further compressed to ~ 1Gb using zip. 



A general lesson I take from this is actually anything that doesn't rely on game state like player's action history can be potentially pre-computed. The only issue is the computational time and storage. If the database is too large and computing one thing is fast, then compute it on the fly may be a better choice. But here 

[^3]: The way we leverage symmetry is detailed in the appendix. 

## Estimate Win Rate

Given this database, we can **instantaneously** estimate many aspect of the game given public cards! 

In this section, I'll talk about "naïve" win rate estimation, i.e. without guessing other's card. This is effectively assuming a uniform distributed prior for  others' private card.  (their cards are distributed in any non-colliding row with my card.)

Before diving into calculation, let's first fix the notations. In the following sections we use these symbols, all assuming the first 3 public cards are revealed:

* $$PUB$$ is the discrete random variable representing the last 2 public cards. 
* $$PRV_i$$ is the discrete variable representing private card sets for player $i$.  
  * These random variable's distribution can easily be represented by a 1176 weight vector, or an index set indicating the rows / columns.
  * For public sets, we should always assume it distributes uniformly after excluding colliding possibilities. 
* The collision function $C(PRV_i,PUB)$ is a Boolean function or matrix, indicating which sets of private cards are not compatible with the public cards and vise versa. 
  * Note this function is symmetric to its two variables. i.e. the collision matrix is also symmetric, if we order the row and columns in the same way. 

* The percentile function $$S(PRV_i,PUB)$$ is the private cards' percentile, which could be represented by a float matrix with some NaN values. Here I adopted the convention of descending percentile. (e.g. $S(PRV_i,PUB)=0$ is the strongest private set). 

Thus the win rate of your card sets estimated naively is the following, (you are the $i$ player and assuming set of players on table is $Ply$)


$$
\mathbb E\{\prod_{j\in Ply,j\neq i}[S(PRV_j,PUB)>S(PRV_i,PUB)]\}\\
=\sum_{PUB}P(PUB)\prod_{j\in Ply,j\neq i}\sum_{PRV_j}(S(PRV_j,PUB)>S(PRV_i,PUB))P(PRV_j)
$$


Given a uniform and independent distribution[^2] to $$PRV_j$$ then the expression above could be written simply 


$$
\sum_{PUB}P(PUB)(1-S(PRV_i,PUB))^{\|Ply\|-1}
$$


$\|Ply\|$ is the number of player on table. This naive win rate can be computed efficiently from the table $$S$$ by exponentiating and averaging one row! 

This result is both illuminating and limited. This expression captures the fact that generally the fewer player on table, the more probable for you to win! This fact leads players to reduce the number of player on table by raising draw. 

But it's also limiting, as it assumes a flat distribution to other's card, this can be a good approximation at the start of the game; but at the end, **those who have not folded are generally much stronger than average**. Then a flat prior can be too optimistic, and this expression can be over-estimating your win rate. 

Nonetheless, this expression is highly useful in the case when no information about other's card is available and it's super efficient. Further, the first equation can incorporate our belief distribution of other's card, thus is still a useful framework. 

[^2]: which is definitely not true, but it's approximating when we have no knowledge of other's cards 

## Decision Making 

In each stage of the game, we are facing a decision making problem, the decisions are "Fold", "Follow" or "Raise". Within "Raise", we can choose the amount of draw we'd like to use (including All In). In a broader scope, this whole problem is a sequential decision making problem. 

I modelled this decision process in two stage (2 layer decision tree). First the agent decides to Fold or not, based on some rough estimation of win rate; then if not fold, decide the amount of draw, by estimating the potential income given my draw. 

The general framework to treat this decision problem is that each action will give rise to a distribution of incomes (rewards). We will choose the action to maximize the mean outcome or maximize a certain percentile of outcome. (like maximize lower bound is the same as minimize loss, maximize a higher percentile is the same as risk seeking.) 

Let's first use the decision of Fold or not as example. Given your current draw $d_i$ and the maximal draw $\bar d$ 

Fold will result in a fixed loss of money $-d_i$ . 

Not fold and follow will result in a distribution of outcomes but we can estimate it roughly by 
$$
p(win_i)*(\mathbb E[RawIncome\mid win_i]-\bar d) -(1-P(win_i)) * \bar d\\
=p(win_i)*\mathbb E[RawIncome\mid win_i]-\bar d
$$
A key part is the Expected raw income $\mathbb E[RawIncome\mid win_i]$ . We know a lower bound for this expected income, however it's much more involved to estimate its exact value. 
$$
\mathbb E[RawIncome\mid win_i] > MoneyOnTable + \bar d - d_i
$$
So in the next section I'll specifically describe how to estimate this expectation by Monte Carlo simulation. 

Currently this decision is made by comparing the two expectation values. 

## Estimating Income

Note in the game of Hold'em, you do not have a fixed reward size like in bandit. You are controlling your income size by adjusting your raising and following behavior. 



## Appendix: Leveraging Symmetry in Card Sets 







