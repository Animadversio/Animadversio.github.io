



## Fitting Linear Nonlinear Poisson Model





### Poisson Likelihood

We know that the Poisson distribution reads
$$
Pr(X=k\mid\lambda)=\frac{\lambda^ke^{-\lambda}}{k!}\\
\log Pr(X=k\mid\lambda)=k\log \lambda -\lambda -\log k!
$$
Here we have a bunch of discrete data like spike counts $y_i$ and paired input data $x_i$. We have assumed a functional form to transform $x$ into the rate $f(x)$. Given the data, how can we write down a loss function to optimize? 
$$
\mathcal L=\sum_i \log Pr(y_i\mid f(x_i))\\
=\sum_i y_i\log f(x_i)-f(x_i)-\log y_i!\\
=\sum_i y_i\log f(x_i)-f(x_i)+const
$$
If $f=f_\theta$ we can do derivative to the parameters
$$
\partial_\theta\mathcal L=\sum_i (\frac{y_i}{f(x_i)}-1)\partial_\theta f(x_i)
$$
For example, $f(x)=max(a(x-b),0)+c$ 
$$
\partial_c f=1\\
\partial_b f=-a\; if\; x>b\;else\;0\\
\partial_a f=x\; if\; x>b\;else\;0\\
$$






A demo from Jonathan Pillow lab is this. https://github.com/pillowlab/LNPfitting





