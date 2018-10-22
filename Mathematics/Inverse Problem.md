Inverse problems are usually characterized by the ill-posedness, i.e. the solution of problem is sensitively dependent on the input (data). But the Forward problem does not. 

Formalism: $x\in X, y\in Y$ is the input and output, and the system characterized by a mapping $K(p)$ may be parametrized by some model parameters $p\in P$ . Thus there are 3 kinds of problems: 

1. Forward problem: Given $x,K(p)$ , find $y=K(p)x$ 
2. Reconstruction problem: Given $y, K(p)$, find $x, s.t. y=K(p)x$ 
3. System Identification: Given pairs of $x_i,y_i$ data, find system esp. parameters $p$ , $y=K(p)x$

The latter 2 problems are all inverse problems, esp. 