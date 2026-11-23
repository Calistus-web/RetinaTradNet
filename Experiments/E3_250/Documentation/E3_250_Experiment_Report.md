# E3_250 Experiment Report

## 1. Experiment overview

**Experiment:** E3_250  
**Project:** RetinaTradNet / original RetinaRegNet evaluation pipeline  
**Dataset:** FIRE retinal image registration dataset  
**Feature-point budget:** 250 SIFT points + 250 random points = 500 total points

E3_250 investigates the effect of reducing the feature-point budget while keeping the existing RetinaRegNet registration pipeline and its other configured parameters unchanged.

## 2. Experimental configuration

| Parameter | Configuration |
|---|---|
| SIFT feature points | 250 |
| Random feature points | 250 |
| Total feature points | 500 |
| Image size | 920 |
| Stable Diffusion model | Stable Diffusion 2.1 |
| Ensemble size | 8 |
| Diffusion timestep | 1 |
| Upsampling index | 2 |
| Stage 1 transformation | Homography |
| Stage 2 transformation | Third-order polynomial |
| Stage 1 affine outlier rejection threshold | 25 |
| Stage 2 affine outlier rejection threshold | 15 |
| Dataset | FIRE (A, P and S categories) |

The feature-point budget was reduced proportionally for the SIFT and random point sets. This evaluates the combined point budget, not the independent contribution of each point type.

## 3. Execution environment and completion

- **HPC system:** CSC Roihu
- **GPU:** NVIDIA GH200 (120 GB)
- **Software environment:** Python 3.12.12; PyTorch 2.10.0+cu130
- **Slurm job ID:** `3336762`
- **Job state:** COMPLETED
- **Exit code:** `0:0`
- **Elapsed time:** 02:07:05

The job completed successfully. The E3 results directory contained **1,210 files** and occupied **5.1 GB**. Successful execution and file generation establish that the run completed; they do not, by themselves, establish registration accuracy.

## 4. Registration accuracy

The AUC values printed by the FIRE evaluation log were:

| FIRE category | AUC |
|---|---:|
| A | 0.768571 |
| P | 0.776327 |
| S | 0.935211 |
| **Entire database** | **0.859701** |

The overall AUC is approximately **85.97%**.

For Case 70, the logged landmark errors were:

| Measurement | Landmark error |
|---|---:|
| Before registration | 259.5695 px |
| After registration | 3.4667 px |

This is one example case, not an aggregate measure of all FIRE pairs.

## 5. Comparison with previous experiments

| Experiment | SIFT points | Random points | Total points | Overall AUC | Runtime |
|---|---:|---:|---:|---:|---:|
| Baseline | 1,000 | 1,000 | 2,000 | 0.901194 | 03:50:03 |
| E1_750 | 750 | 750 | 1,500 | 0.896418 | 02:24:38 |
| E2_500 | 500 | 500 | 1,000 | 0.888358 | 02:29:11 |
| **E3_250** | **250** | **250** | **500** | **0.859701** | **02:07:05** |

Relative to baseline:
- E3 uses **75% fewer feature points**.
- Its overall AUC is lower by approximately **0.041493**, or **4.15 percentage points**.
- It retains approximately **95.40%** of the baseline overall AUC.
- Its recorded elapsed time is approximately **44.7% shorter**.

These are single-run runtime observations. HPC scheduling and system load can affect elapsed time; the measurements do not establish a guaranteed or strictly proportional runtime reduction. E2, for example, took slightly longer than E1.

## 6. Interpretation

E3 demonstrates successful pipeline execution with a substantially smaller feature-point budget. Its lower overall AUC compared with baseline indicates an accuracy-efficiency trade-off as the budget is reduced.

E3 has the smallest point budget and shortest recorded runtime among the tested configurations, but also the lowest overall AUC. Whether this trade-off is acceptable depends on the accuracy requirements of the intended application. These results compare the tested configurations; they do not establish a universal optimal budget.

## 7. Methodological notes and limitations

1. The experiment changes the combined SIFT-plus-random point budget; it does not isolate the effects of the two point types.
2. Runtime comparisons are based on one run per configuration and should be interpreted cautiously.
3. AUC values are those printed by the existing evaluation script, using its 0–25 pixel threshold range. The evaluation implementation and denominator should remain consistent across experiments.
4. Case 70 is illustrative only and does not replace aggregate evaluation.
5. The generated result directory is 5.1 GB. The Windows archive can retain the script, Slurm file, logs and report without copying the large generated results, consistent with E1 and E2.

## 8. Reproducibility and file locations

**Roihu experiment output:**  
`/scratch/project_2020210/RetinaTradNet/Experiments/E3_250`

**E3 Python script:**  
`/scratch/project_2020210/RetinaTradNet/retinaregnet_fire_evaluation_E3_250.py`

**E3 Slurm script:**  
`/scratch/project_2020210/RetinaTradNet/run_retinaregnet_fire_E3_scratch.slurm`

**Slurm standard output:**  
`/scratch/project_2020210/RetinaTradNet/slurm_log/retinaregnet_fire_E3_3336762.out`

**Slurm error log:**  
`/scratch/project_2020210/RetinaTradNet/slurm_log/retinaregnet_fire_E3_3336762.err`

---

**Conclusion:** E3_250 completed successfully using 500 total feature points. It achieved an overall FIRE AUC of 0.859701, retaining approximately 95.40% of baseline AUC, with a recorded runtime of 02:07:05. It is the lowest-budget configuration in the current experiment series and quantifies the associated reduction in registration accuracy.
