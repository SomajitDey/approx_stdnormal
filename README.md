# Fast PRNG for approximate standard normal distribution

This [pseudorandom number generator (PRNG)](/stdnormal.f90) for sampling approximately standard normal deviates is based on the well-known [Box-Muller](https://en.wikipedia.org/wiki/Box-Muller_transform) transform. However, it circumvents the use of computationally expensive trigonometric functions as in the original Box-Muller technique, as well as the wasteful rejection sampling method of [Bell and Knop](https://en.wikipedia.org/wiki/Marsaglia_polar_method).

The distribution of the generated random numbers very closely resembles the standard normal distribution. The difference mainly lies in the probability at X=0. To test its accuracy, build and run the sample program with `make` (builds with gfortran) or `make FC=ifort` and probe the statistics of the generated variates using the [attached gnuplot script](/statistics.gnuplot).

This PRNG may be used as a performance-oriented approximation to the standard normal distribution, or, whenever a unimodal, symmetric, mesokurtic distribution of zero mean and unit variance is required.

## The Math behind

Suppose $Z$ denotes a standard normal variate and $U$ a variate from a uniform distribution $\epsilon \ [0,1]$.

Box-Muller transform says: 

$Z_1 = Rcos(\theta)$ and $Z_2 = Rsin(\theta)$, where $R = \sqrt{-2lnU_1}$ and $\theta = 2\pi U_2$.

We approximate $cos(\pi x)$ and $sin(\pi x)$ above with $\pm {1-x^2 \over 1+x^2}$ and $2x \over 1+x^2$ respectively, for $x \ \epsilon \ [-1,1]$.

For us:

Sample $U$ from $[-1,1]$ uniformly. Then, 

$Z_1 = \sqrt{-lnU_1^2}{1-U_2^2 \over 1+U_2^2}{U_1 \over |U_1|}$ and

$Z_2 = \sqrt{-lnU_1^2}{2U_2 \over 1+U_2^2}$

Above, ${U_1 \over |U_1|}$ is to provide $\pm$ with equal probability.

## License
[MIT](https://opensource.org/license/mit/)
