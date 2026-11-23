# RetinaTradNet 

## Evaluating the Trade-off Between Computational Efficiency and Registration Accuracy in Zero-Shot Retinal Image Registration Through Feature-Point Budget Optimization

1. Project Overview

RetinaTradNet investigates the relationship between feature-point
budget, computational efficiency, and registration accuracy in zero-shot
retinal image registration.

The study evaluates how reducing the number of feature points used by
RetinaRegNet affects retinal image registration performance and
computational runtime.

Four experimental configurations are evaluated using the FIRE retinal
image registration dataset.

2. Research Question

How does reducing the number of feature points used by RetinaRegNet
affect retinal image registration accuracy and computational efficiency?

3. Experimental Methodology

  Experiment     SIFT Points   Random Points   Total Points   Reduction
  ------------ ------------- --------------- -------------- -----------
  Baseline             1,000           1,000          2,000          0%
  E1_750                 750             750          1,500         25%
  E2_500                 500             500          1,000         50%
  E3_250                 250             250            500         75%

Fixed Experimental Parameters

-   Registration framework: RetinaRegNet
-   Diffusion model: Stable Diffusion 2.1
-   Image size: 920
-   Ensemble size: 8
-   Timestep: 1
-   Upsampling index: 2
-   Stage 1 transformation: Homography
-   Stage 2 transformation: Third-order polynomial
-   Outlier thresholds: 25 and 15
-   Dataset: FIRE
-   Evaluation categories: A, P and S

4. Experimental Results

4.1 Overall Registration Accuracy

Registration accuracy was evaluated using the Area Under the Curve
(AUC).

  Experiment     Overall AUC
  ------------ -------------
  Baseline          0.901194
  E1_750            0.896418
  E2_500            0.888358
  E3_250            0.859701

4.2 Computational Runtime

  Experiment      Runtime
  ------------ ----------
  Baseline       03:50:03
  E1_750         02:24:38
  E2_500         02:29:11
  E3_250         02:07:05

4.3 Category-Specific AUC

  Experiment     Category A   Category P   Category S
  ------------ ------------ ------------ ------------
  Baseline         0.814286     0.852245     0.952113
  E1_750           0.817143     0.837551     0.952676
  E2_500           0.800000     0.826939     0.948169
  E3_250           0.768571     0.776327     0.935211

4.4 Key Findings

-   E1_750 retained approximately 99.47% of baseline AUC, with a
    recorded runtime reduction of approximately 37.1%.
-   E2_500 retained approximately 98.58% of baseline AUC, with a
    recorded runtime reduction of approximately 35.2%.
-   E3_250 retained approximately 95.40% of baseline AUC, with a
    recorded runtime reduction of approximately 44.7%.
-   Category P showed greater sensitivity to feature-point reduction,
    while Category S maintained comparatively higher registration
    performance.
-   Runtime did not decrease monotonically with feature-point reduction.
    In particular, E2_500 took slightly longer than E1_750.

These observations are based on the recorded experimental runs.

5. Repository Structure

    RetinaTradNet/
    ├── README.md
    ├── .gitignore
    └── Experiments/
        ├── Baseline_20261122/
        │   ├── Documentation/
        │   ├── Script/
        │   └── Slurm/
        ├── E1_750/
        │   ├── Documentation/
        │   ├── Scripts/
        │   └── Slurm/
        ├── E2_500/
        │   ├── Documentation/
        │   ├── Scripts/
        │   └── Slurm/
        └── E3_250/
            ├── Documentation/
            ├── Scripts/
            └── Slurm/

6. Experiment Directory Contents

Each experiment directory contains the relevant research materials:

-   Documentation: Experiment reports describing configurations, results
    and observations.
-   Scripts: Python evaluation scripts used to execute the experiments.
-   Script: Python evaluation script for the baseline experiment.
-   Slurm: HPC job submission scripts and execution logs.

Generated registration images are retained locally but excluded from the
GitHub repository to reduce repository size.

7. Computational Environment

The experiments were executed using the Roihu High-Performance Computing
(HPC) environment.

The confirmed baseline execution environment included:

-   GPU: NVIDIA GH200 120GB
-   PyTorch: 2.10.0+cu130
-   CUDA availability: True

8. Dataset and Original Implementation

The experiments use the FIRE retinal image registration dataset and the
RetinaRegNet framework.

The original RetinaRegNet project is maintained separately from this
experimental repository. The original implementation and dataset are not
included in this repository.

Users wishing to reproduce the experiments should obtain the required
implementation and dataset separately, subject to their respective
licensing and access conditions.

9. Research Objective

The primary objective is to investigate whether reducing the
feature-point budget can improve computational efficiency while
preserving acceptable retinal image registration accuracy.

The experimental results provide a comparative assessment of
registration performance and computational runtime across different
feature-point configurations.

10. Acknowledgements

This research builds upon the RetinaRegNet framework. Appropriate
acknowledgement and citation of the original implementation and
associated research work should be provided when using or extending this
experimental repository.