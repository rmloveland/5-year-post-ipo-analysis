# 5-year post-IPO analysis

This is just a quick hack to analyze the performance of the stock
prices of a group of companies over time.

It reads every file in the `csv` directory, gets the earliest and
latest prices for that company, and prints the multiple.

At the moment, every file in the `csv` directory has data downloaded
from <finance.{google,yahoo}.com> that tracks a public company's
performance over the first five years after IPO (expressed as a
multiple of its IPO stock price).

## Usage

Assuming you have the prerequisites installed:

```
> (load "c:/Users/rml/Dropbox/Code/personal/5-year-post-ipo-analysis/analyze.lisp")
T

> (print-analysis)
YHOO-19960412-20010412
6.144927
GOOG-20040819-20090819
4.424581
FB-20120518-20160518
3.974662
...
```

## Prerequisites

+ CL-CSV
+ CL-FAD
