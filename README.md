# HPC_week_6
## Homework for the 6th week

### 7 Small GEMMs: SVE

#### 7.2 The Unrolled Part

For this part it was necessary to rewrite the kernel from 6.2 to work on SVE registers and with according operations. With the porofided template the following performance could be achieved:

    # of executions: 150000000
    duration: 2.49922 seconds
    average duration: 1.66615e-08 seconds
    GFLOPS: 23.0472

Since only `Z8` of the callee saved registers are used in the program the loads and restres of the others were removed from it. This resulted in the following:

    # of executions: 150000000
    duration: 2.0616 seconds
    average duration: 1.3744e-08 seconds
    GFLOPS: 27.9395

Changing the used register from `Z8` to `Z16` results in a noticable performance improvement of approx 0.5 GFLOPs:

    # of executions: 150000000
    duration: 2.02134 seconds
    average duration: 1.34756e-08 seconds
    GFLOPS: 28.496

Next it was tried to load as much data in advance as possible before any fmla operation is fired. For that only non callee saved registers shall be used.

    # of executions: 150000000
    duration: 2.14307 seconds
    average duration: 1.42872e-08 seconds
    GFLOPS: 26.8773

This barely changes the performance of the program. This means a pure utilization of more registers does not necessarily lead to a better performance. In this case it even drops.

With the loop over `k` the following performance could be achieved:

    # of executions: 10000000
    duration: 5.35882 seconds
    average duration: 5.35882e-07 seconds
    GFLOPS: 34.3956

#### 7.3 The Unrolled Part

