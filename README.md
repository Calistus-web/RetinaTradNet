# RetinaTradNet

**Evaluating the Trade-off Between Computational Efficiency and Registration Accuracy in Zero-Shot Retinal Image Registration Through Feature-Point Budget Optimization**

## Project Overview

RetinaTradNet investigates the relationship between feature-point budget,
computational efficiency, and registration accuracy in zero-shot retinal
image registration.

The study measures how reducing the number of feature points used by
RetinaRegNet affects retinal image registration performance and runtime.
Four feature-point configurations are evaluated on the FIRE retinal image
registration dataset.

## Research Question

How does reducing the number of feature points used by RetinaRegNet affect
registration accuracy and computational efficiency?

## Experimental Configurations

| Experiment | SIFT points | Random points | Total points | Reduction |
| Baseline | 1,000 | 1,000 | 2,000 | 0% |
| E1_750 | 750 | 750 | 1,500 | 25% |
| E2_500 | 500 | 500 | 1,000 | 50% |
| E3_250 | 250 | 250 | 500 | 75% |

### Fixed Parameters

- Registration framework: RetinaRegNet
- Diffusion model: Stable Diffusion 2.1
- Image size: 920
- Ensemble size: 8
- Timestep: 1
- Upsampling index: 2
- Stage 1 transformation: Homography
- Stage 2 transformation: Third-order polynomial
- Outlier thresholds: 25 and 15
- Dataset: FIRE
- Evaluation categories: A, P, and S

## Experimental Results

### Overall Registration Accuracy

Registration accuracy is reported using Area Under the Curve (AUC).

| Experiment | Overall AUC |
| Baseline | 0.901194 |
| E1_750 | 0.896418 |
| E2_500 | 0.888358 |
| E3_250 | 0.859701 |

### Computational Runtime

| Experiment | Runtime (HH:MM:SS) |
| Baseline | 03:50:03 |
| E1_750 | 02:24:38 |
| E2_500 | 02:29:11 |
| E3_250 | 02:07:05 |

### Category-Specific AUC

| Experiment | Category A | Category P | Category S |
| Baseline | 0.814286 | 0.852245 | 0.952113 |
| E1_750 | 0.817143 | 0.837551 | 0.952676 |
| E2_500 | 0.800000 | 0.826939 | 0.948169 |
| E3_250 | 0.768571 | 0.776327 | 0.935211 |

### Key Findings

- E1_750 retained approximately 99.47% of the baseline AUC and required
  approximately 37.1% less runtime.
- E2_500 retained approximately 98.58% of the baseline AUC and required
  approximately 35.2% less runtime.
- E3_250 retained approximately 95.40% of the baseline AUC and required
  approximately 44.7% less runtime.
- Category P was more sensitive to feature-point reduction than Categories
  A and S.
- Category S maintained comparatively high registration performance across
  all configurations.
- Runtime was not strictly monotonic: E2_500 required slightly longer than
  E1_750.

These observations are based on the recorded experimental runs.

## Repository Structure

```text
RetinaTradNet/
├── README.md
├── .gitignore
├── Experiments/
│   ├── Baseline_20261122/
│   │   ├── Documentation/
│   │   ├── Script/
│   │   ├── Slurm/
│   │   └── Results/
│   ├── E1_750/
│   │   ├── Documentation/
│   │   ├── Scripts/
│   │   ├── Slurm/
│   │   └── Results/
│   ├── E2_500/
│   │   ├── Documentation/
│   │   ├── Scripts/
│   │   ├── Slurm/
│   │   └── Results/
│   └── E3_250/
│       ├── Documentation/
│       ├── Scripts/
│       ├── Slurm/
│       └── Results/

```

## Experiment Files

| Experiment | Report | Evaluation script |
|---|---|---|
| Baseline | [Baseline report](Experiments/Baseline_20261122/Documentation/Baseline_Experiment_Report.md) | [Baseline script](Experiments/Baseline_20261122/Script/retinaregnet_fire_evaluation_mirror.py) |
| E1_750 | [E1 report](Experiments/E1_750/Documentation/E1_750_Experiment_Report.md) | [E1 script](Experiments/E1_750/Scripts/retinaregnet_fire_evaluation_mirror.py) |
| E2_500 | [E2 report](Experiments/E2_500/Documentation/E2_500_Experiment_Report.md) | [E2 script](Experiments/E2_500/Scripts/retinaregnet_fire_evaluation_E2_500.py) |
| E3_250 | [E3 report](Experiments/E3_250/Documentation/E3_250_Experiment_Report.md) | [E3 script](Experiments/E3_250/Scripts/retinaregnet_fire_evaluation_E3_250.py) |

Each experiment directory contains the relevant documentation, scripts, HPC
submission materials, logs, and generated results.

## Computational Environment

The experiments were executed in the Roihu High-Performance Computing
(HPC) environment.

- GPU: NVIDIA GH200 120GB
- PyTorch: 2.10.0+cu130
- CUDA availability: True

## Dataset and Original Implementation

The experiments use the FIRE retinal image registration dataset and the original
RetinaRegNet framework. The original RetinaRegNet implementation is
 retained in `Original_RetinaRegNet/` for local use and is excluded
from repo. Dataset and implementation access remain subject to
their respective licensing and access conditions.

Users reproducing the experiments must obtain the required implementation
and dataset separately and ensure that their paths match the evaluation
scripts.

## Research Objective

The primary objective is to determine whether reducing the feature-point
budget improves computational efficiency while preserving acceptable
retinal image registration accuracy.

## Acknowledgements

This research builds upon the RetinaRegNet framework. Please cite and
acknowledge the original implementation and associated research work when
using or extending this repository.
