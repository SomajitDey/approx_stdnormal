# Fast PRNG for approximate standard normal distribution

This [pseudorandom number generator (PRNG)](/stdnormal.f90) for sampling approximately standard normal deviates is based on the well-known [Box-Muller](https://en.wikipedia.org/wiki/Box-Muller_transform) transform. However, it circumvents the use of computationally expensive trigonometric functions as in the original Box-Muller technique, as well as the wasteful rejection sampling method of [Bell and Knop](https://en.wikipedia.org/wiki/Marsaglia_polar_method).

The distribution of the generated random numbers very closely resembles the standard normal distribution. The difference mainly lies in the probability at X=0. To test its accuracy, build and run the sample program with `make` (builds with gfortran) or `make FC=ifort` and probe the statistics of the generated variates using the [attached gnuplot script](/statistics.gnuplot).

This PRNG may be used as a performance-oriented approximation to the standard normal distribution, or, whenever a unimodal, symmetric, mesokurtic distribution of zero mean and unit variance is required.

## License
[MIT](https://opensource.org/license/mit/)
