# Baseline Experiment Report
## RetinaTradNet: Retinal Image Registration Using the Full Feature-Point Budget

### 1. Experiment Overview

The baseline experiment establishes the reference performance of RetinaRegNet for retinal image registration using the full feature-point budget. It serves as the control experiment against which the reduced feature-point configurations (E1_750, E2_500 and E3_250) are evaluated.

The purpose is to establish the registration accuracy and computational runtime achieved without reducing the number of feature points.

### 2. Experimental Configuration

| Parameter | Baseline Configuration |
|---|---|
| Registration framework | RetinaRegNet |
| SIFT feature points | 1,000 |
| Random feature points | 1,000 |
| Total feature points | 2,000 |
| Feature-point reduction | 0% |
| Diffusion model | Stable Diffusion 2.1 |
| Image size | 920 |
| Ensemble size | 8 |
| Timestep | 1 |
| Upsampling index | 2 |
| Stage 1 transformation | Homography |
| Stage 2 transformation | Third-order polynomial |
| Outlier thresholds | 25 and 15 |
| Evaluation dataset | FIRE |
| Evaluation categories | A, P and S |

### 3. Execution Environment

The baseline evaluation was executed on the Roihu HPC environment using a GPU-enabled SLURM job.

| Item | Execution Details |
|---|---|
| SLURM job ID | 3313907 |
| GPU | NVIDIA GH200 120GB |
| PyTorch version | 2.10.0+cu130 |
| CUDA availability | True |
| Execution start | 22 November 2026, 00:21:44 EET |
| Total runtime | 03:50:03 |

### 4. Registration Performance

The baseline achieved an overall AUC of **0.9011940299**.

| FIRE Category | AUC |
|---|---:|
| A | 0.8142857143 |
| P | 0.8522448980 |
| S | 0.9521126761 |
| **Overall** | **0.9011940299** |

### 5. Computational Performance

The baseline evaluation required 3 hours, 50 minutes and 3 seconds to complete.

This runtime represents the reference computational cost for the full 2,000-feature-point configuration. Subsequent experiments will compare their execution times against this baseline.

### 6. Baseline Significance

The baseline provides the reference point for investigating the trade-off between computational efficiency and registration accuracy.

Its overall AUC of 0.9011940299 represents the accuracy benchmark for the subsequent reduced-budget experiments. Its runtime of 03:50:03 provides the reference against which computational savings will be calculated.

### 7. Conclusion

The baseline experiment establishes the reference performance of RetinaRegNet using 2,000 feature points, comprising 1,000 SIFT and 1,000 random points.

The framework achieved an overall AUC of 0.9011940299 with a total execution time of 03:50:03.

These results will serve as the control measurements for evaluating the effects of reducing the feature-point budget by 25%, 50% and 75% in the subsequent experiments.

---

**Experiment:** Baseline_20261122  
**Framework:** RetinaRegNet  
**Dataset:** FIRE  
**Status:** Completed
