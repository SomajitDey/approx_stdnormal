#!/usr/bin/env -S gnuplot --persist
# This is a gnuplot script to display statistics of the generated standard normal variates

datfile = 'variates.dat'

set autoscale

stats datfile nooutput
print 'Sample size: ', STATS_records
print 'Mean: ', STATS_mean
print 'Std. dev: ', STATS_stddev
print 'Skewness: ', STATS_skewness
print 'Kurtosis: ', STATS_kurtosis
print 'Quartiles: ', STATS_lo_quartile, ' & ', STATS_up_quartile

# Plotting normalized histogram

binwidth = 0.1
bin(val) = binwidth*floor(val/binwidth) + binwidth/2.0
set boxwidth binwidth
plot datfile using (bin($1)):(1.0/STATS_records) smooth frequency with boxes title 'Normalized frequency'
