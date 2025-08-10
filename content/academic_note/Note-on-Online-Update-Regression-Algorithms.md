---
layout: post
title: Note on Online Linear Regression Algorithm
author: Binxu Wang
date: Dec 15th, 2019
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Applied Math, Linear Algebra, Numerical Method]
---

* TOC
{:toc}


# Note on Online Regression Algorithm

## Least Square Problem 

Classical least square linear regression is 
$$
\hat \beta_{ls}=\arg\min_\beta\|y-X\beta\|^2_2
$$
With regularizations it becomes a ridge or lasso regression problem 
$$
\hat \beta_{ridge}=\arg\min_\beta\|y-X\beta\|^2_2+\lambda\|\beta\|_2^2
$$

$$
\hat \beta_{lasso}=\arg\min_\beta\|y-X\beta\|^2_2+\lambda\|\beta\|_1
$$
And the loss functions for least square and ridge regression are quadratic functions,  


$$
\mathcal L_{ls} = \beta^T X^TX\beta -2y^TX\beta\\
\mathcal L_{ridge} = \beta^T (X^TX+\lambda I)\beta -2y^TX\beta
$$
for which gradient are easy to obtain, 


$$
\partial_\beta\mathcal L_{ls} = 2X^TX\beta -2X^Ty\\
\partial_\beta\mathcal L_{ridge} = 2(X^TX+\lambda I)\beta -2X^Ty
$$


and to solve it you can invert the $X^TX$ data matrix. (Note as $\lambda=0$ ridge regression will go back to least square, we don't treat them separately. )
$$
\hat\beta_{ridge}=(X^TX+\lambda I)^{-1}X^Ty
$$
A way to work around matrix inversion is to compute SVD for $X$ first. If $X=U\Sigma V^T$, then $X^TX=V\Sigma^2V^T$ , and $(X^TX)^{-1}=V\Sigma^{-2}V^T$ if $\Sigma$ is rank $p$ (number of predictors. ) i.e. no 0 singular value. 

Note that, for ridge regression, it is actually manipulating the spectrum of $X^TX$ so that all the singular values are $\geq\lambda$, thus make the problem not ill-posed. 

## Online Algorithm

For some reason, if there are too many predictors or too many data samples, such that this matrix inverse is unable to be perform as a whole, then we must use an online update version of regression. 

We can write a single sample version of algorithm, $x_i$ is a row vector of all the predictors. 
$$
\hat\beta_{ridge}=(\sum_ix_i^Tx_i+\lambda I)^{-1}\sum_ix_i^Ty_i
$$
Denote 
$$
A_i=(\sum_ix_i^Tx_i+\lambda I)\\
b_i=\sum_ix_i^Ty_i\\
\hat\beta_{ridge}^{(i)} = A_i^{-1}b_i
$$
So we can compute the ridge regression predictor without seeing all the data. 

## Rank 1 update of Matrix Inverse

As is shown above, if the matrix inverse is computed every turn or every batch, it will be **very inefficient**, as inverse is a $O(n^3)$ operation. But we can use the inverse compute at last point to ease this computation, i.e. find a formula connecting $A_{i+1}^{-1}\sim A_i^{-1}$. 
$$
A_{i+1}=A_i+x_i^Tx_i
$$
The [Sherman-Morrison_formula](https://en.wikipedia.org/wiki/Sherman–Morrison_formula) is doing exactly this thing. 


$$
(A+uv^{\textsf {T}})^{-1}=A^{-1}-{A^{-1}uv^{\textsf {T}}A^{-1} \over 1+v^{\textsf {T}}A^{-1}u}.
$$
In the simplest version, it's like 
$$
(I+uv^\textsf T)^{-1}=I- {uv^\textsf T\over1+v^\textsf Tu} 
$$
And it's simple to derive SM formula by changing of variable $u=Aw$
$$
(A+uv^\textsf T)^{-1}=(A+Awv^T)^{-1}\\=(I- {wv^\textsf T\over1+v^\textsf Tw} )A^{-1}=A^{-1}-{A^{-1}uv^\textsf TA^{-1}\over1+v^\textsf TA^{-1}u}
$$
So in our specific case 
$$
A_{i+1}^{-1}=A_{i}^{-1}-{A_{i}^{-1}x_i^Tx_iA_{i}^{-1}\over1+x_iA_{i}^{-1}x_i^T}
$$
Note that as $X^TX$ is a semi-positive definite matrix, the inverse is also a positive definite matrix. $A_i^{-1}=A_i^{-T}$ 

## Rank-c batch update of Matrix Inverse

If we want to add multiple samples together, then we will update the matrix with a rank $b$ matrix $\sum_i^bx_i^Tx_i={X_b}^TX_b$. $X_b$ is a slice of the whole data matrix $X_b=X(i:i+b,:)$ 

[Woodbury_Matrix_Identity](https://en.wikipedia.org/wiki/Woodbury_matrix_identity) is doing exactly this
$$
(A+UCV)^{-1}=A^{-1}-A^{-1}U(C^{-1}+VA^{-1}U)^{-1}VA^{-1}
$$
In our case 
$$
A_{i+1}^{-1}=(A_{i}+X_b^TX_b)^{-1}=A_{i}^{-1}-{A_{i}^{-1}X_b^T (I_b+X_bA_{i}^{-1}X_b^T)^{-1} X_bA_{i}^{-1}}
$$


## Usage Cases

Note online learning for regression majorly suit the case when the $n$ of data i.e. sample number is very high, such that you cannot fit all the data at once. 

But when $p$ is very high such that it cannot fit in memory, then online method will not help, since $p\times p$ matrix $A^{-1}$ will still be huge and online method will make problem more memory intensive than $X$ itself. For that purpose, stochasitic gradient descent may be even better, as convergence is guaranteed.

[Ref CMU ML Early Stop for ML](https://blog.ml.cmu.edu/2019/03/07/a-continuous-time-view-of-early-stopping-for-least-squares/)



## Further Info 

Actually, most modern numerical linear algebra environments have automatic method to select the right algorithms for the scale of the linear problem. See 

* If you are tackling high dimensional regression problem, see [tutorial in matlab fitrlinear](https://www.mathworks.com/help/stats/fitrlinear.html) 
  * This is a Matlab function to fit high dimensional linear regression problem with regularization and automatic hyper-parameter tuning! Really useful
* Python Scikit-Learn has many packages for LinearRegression, see [Linear models](https://scikit-learn.org/stable/modules/classes.html#module-sklearn.linear_model)  but they are not as well integrated as the matlab verson. 



## See also

[Note on Online Computing Correlation](Brief-Note-on-Online-Computing-Correlation) 

