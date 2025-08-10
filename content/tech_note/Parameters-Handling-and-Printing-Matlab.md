---
layout: post
title: Handling and Printing Parameters in matlab
author: Binxu Wang
use_math: true
comments: true
date: Mar. 3rd, 2020
categories: [coding]
tags: [matlab, coding]
---

# Motivation

Handling parameter and recording them for numerical experiment is a pain in matlab. 





# Solutions

## Option Parser

Input the options as different fields of a structure and parse it through a function, fill in the fields that are missing by checking `isfield`

```matlab
function parseParameters(self, opts)
            if ~isfield(opts, "population_size"), opts.population_size = 40; end
            if ~isfield(opts, "select_cutoff"), opts.select_cutoff = opts.population_size / 2; end    
            if ~isfield(opts, "lr_norm"), opts.lr_norm = 40; end
            if ~isfield(opts, "mu_norm"), opts.mu_norm = 5; end
            if ~isfield(opts, "lr_sph"), opts.lr_sph = 2; end  
            if ~isfield(opts, "mu_sph"), opts.mu_sph = 0.005; end          
            if ~isfield(opts, "Lambda"), opts.Lambda = 1; end
            if ~isfield(opts, "Hupdate_freq"), opts.Hupdate_freq = 5; end
            if ~isfield(opts, "maximize"), opts.maximize = true; end
            if ~isfield(opts, "max_norm"), opts.max_norm = 300; end
            if ~isfield(opts, "rankweight"), opts.rankweight = false; end
            if ~isfield(opts, "rankbasis"), opts.rankbasis = false; end
            if ~isfield(opts, "nat_grad"), opts.nat_grad = false; end
    
            self.B = opts.population_size;  % population batch size
            self.select_cutoff = floor(opts.select_cutoff);
            self.lr_norm = opts.lr_norm;  % learning rate (step size) on radial direction
            self.mu_norm = opts.mu_norm;  % scale of the Gaussian distribution on radial direction
            self.lr_sph = opts.lr_sph; % learning rate (step size) of moving along gradient
            self.mu_sph = opts.mu_sph; % scale of the Gaussian distribution to estimate gradient
            self.Lambda = opts.Lambda;  % diagonal regularizer for Hessian matrix
            self.max_norm = opts.max_norm; % maximum norm to cap 

            assert(self.Lambda > 0)
            self.maximize = opts.maximize;  % maximize / minimize the function
            self.max_norm = opts.max_norm;
            self.rankweight = opts.rankweight; % Switch between using raw score as weight VS use rank weight as score
            self.rankbasis = opts.rankbasis; % Switch between using raw score as weight VS use rank weight as score
            self.nat_grad = opts.nat_grad; % use the natural gradient definition, or normal gradient.
            self.Hupdate_freq = floor(opts.Hupdate_freq);  % Update Hessian (add additional samples every how many generations)
end
```



## Option Representation

To print a `struct` in matlab in a human readable way is not straight forward. 

One of the solution is to loop through the fields and formatting each property by hand. 

```matlab
function fullstr = printOptionStr(options)

Fields = fieldnames(options);
opt_strs = {};
fullstr = "";
for Fi = 1:length(Fields)
    val = getfield(options, Fields{Fi});
    opt_strs{Fi} = sprintf("%s=%s\n",Fields{Fi},num2str(val));
    fullstr = strcat(fullstr, opt_strs{Fi});
end
end
```

This will generate less good looking option strings! Because matlab datatype is fuzzy, and there can be unnecessary 0 in the string! 



Another way is to utilize the `json` format as an intermediate proxy for the final representation, and format that string through string operations in matlab. `strrep` will replace characters in the original string to make it more printable. 

```matlab
function fullstr = printOptionStr(options)
fullstr = jsonencode(options); % use jsonencode as a proxy for text representation of options
fullstr = strrep(fullstr, ':', sprintf(': ')); % increase space after :
fullstr = strrep(fullstr, ',', sprintf(',\r')); % change line after each , 
fullstr = strrep(fullstr, '_', sprintf(' ')); % avoid `_` interpreted as Latex
fullstr = strrep(fullstr, '{', sprintf(''));
fullstr = strrep(fullstr, '}', sprintf(''));
end
```

This representation could be easily `split` at `,` character to be a multi line representation like this `split(printOptionStr(options),',')`



## Annotate parameter setting in figures

Annotating parameters at figure can be done through this function. 

```matlab
annotation(h,'textbox',...
    [0.485 0.467 0.154 0.50],'String',split(printOptionStr(options),','),...
    'FontSize',14,'FitBoxToText','on','EdgeColor','none')
```

Note these kind of code are hard to write a priori, but easy to manipulate the overlay by hand and generate code in matlab from it! 



