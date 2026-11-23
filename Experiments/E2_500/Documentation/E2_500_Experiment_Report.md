# E2_500 Experiment Report

## 1. Experiment identification

| Item | Details |
|---|---|
| Experiment ID | E2_500 |
| Project | RetinaTradNet — evaluation of feature-point budget in RetinaRegNet |
| Dataset | FIRE retinal image registration dataset |
| Feature-point budget | 500 SIFT points + 500 random points |
| Total feature points | 1,000 |
| Slurm job ID | 3331655 |
| Execution status | COMPLETED |
| Slurm exit code | 0:0 |
| Execution date | 22–23 November 2026 |

## 2. Objective

E2_500 evaluates how reducing the total number of feature points used by the existing RetinaRegNet registration pipeline affects registration accuracy and computational runtime.

The experiment uses 1,000 total feature points, compared with 2,000 in the baseline and 1,500 in E1_750. The aim is to measure the accuracy–efficiency trade-off without changing the underlying registration architecture.

## 3. Experimental configuration

| Parameter | E2_500 setting |
|---|---:|
| SIFT feature points | 500 |
| Random feature points | 500 |
| Total feature points | 1,000 |
| Image size | 920 |
| Ensemble size | 8 |
| Diffusion timestep | 1 |
| Upsampling index | 2 |
| Stage 1 transformation | Homography |
| Stage 2 transformation | Third-order polynomial |
| Stage 1 affine outlier-rejection threshold | 25 |
| Stage 2 affine outlier-rejection threshold | 15 |
| Dataset | FIRE (A, P and S categories) |

The feature-point budget was reduced proportionally: both the SIFT and random point counts were set to 500. This experiment therefore evaluates the combined feature-point budget; it does not independently measure the contribution of SIFT points versus random points.

All other listed pipeline settings were kept consistent with the baseline and E1_750 experiments.

## 4. Computing environment and execution

The experiment was executed on the CSC Roihu HPC environment using a GH200 GPU allocation.

| Item | Recorded value |
|---|---|
| Slurm job ID | 3331655 |
| Partition | gpumedium |
| GPU allocation | 1 × GH200 |
| CPUs per task | 8 |
| Python environment | `.venv_gpu` |
| PyTorch | 2.10.0+cu130 |
| CUDA available | Yes |
| Job start | 22 Nov 2026, 21:33:05 |
| Job end | 23 Nov 2026, 00:02:16 |
| Elapsed runtime | **02:29:11** |
| Slurm state | COMPLETED |
| Exit code | 0:0 |

The evaluation ran to completion. The result directory contained the expected `Stage1`, `Stage2` and `Final_Registration_Results` folders.

## 5. Results

### 5.1 Registration accuracy

| Metric | E2_500 result |
|---|---:|
| Overall FIRE AUC | **0.888358** |
| S-category AUC | **0.948169** |
| Case 70 landmark error before registration | 259.5695 px |
| Case 70 landmark error after registration | 2.9207 px |

The overall AUC is calculated using the existing evaluation implementation, which evaluates the success-rate curve over landmark-error thresholds from 0 to 25 pixels. The implementation includes unsuccessful cases in the denominator; its failure sentinel of 10,000 pixels does not count as successful at these thresholds.

**Reporting note:** The A-category and P-category AUC values were not present in the verified result summary used to prepare this report. They should be added from the E2 execution log or generated evaluation output if category-level reporting is required. They are intentionally not estimated here.

### 5.2 Pipeline completion and output generation

| Check | Observation |
|---|---|
| Slurm job | Completed successfully, exit code 0:0 |
| Expected result folders | Stage1, Stage2 and Final_Registration_Results present |
| Output files | 1,210 |
| Output directory size | 5.1 GB |

The successful Slurm job confirms that the evaluation script completed. The presence of output files does not, by itself, establish that every individual registration was accurate. Pipeline completion and landmark-based registration success are separate measures.

## 6. Comparison with Baseline and E1_750

| Experiment | SIFT points | Random points | Total points | Overall AUC | Runtime |
|---|---:|---:|---:|---:|---:|
| Baseline | 1,000 | 1,000 | 2,000 | 0.901194 | 03:50:03 |
| E1_750 | 750 | 750 | 1,500 | 0.896418 | 02:24:38 |
| **E2_500** | **500** | **500** | **1,000** | **0.888358** | **02:29:11** |

### 6.1 AUC comparison

Relative to the baseline:

- Absolute overall AUC difference: 0.901194 − 0.888358 = **0.012836**, equivalent to approximately **1.28 percentage points** on a 0–1 AUC scale.
- E2_500 retained approximately **98.58%** of the baseline AUC.

Relative to E1_750:

- E2_500 overall AUC was lower by **0.008060**, equivalent to approximately **0.81 percentage points**.

These results indicate a gradual reduction in overall AUC as the tested feature-point budget decreases. E2_500 nevertheless retained most of the baseline AUC.

### 6.2 Runtime comparison

Relative to the baseline, E2_500 reduced observed elapsed runtime by **1:20:52**, approximately **35.2%**.

E2_500 took **4 minutes 33 seconds longer** than E1_750, despite using fewer feature points. Runtime therefore did not decrease monotonically across these runs. Differences in HPC scheduling, system load and run-to-run variability may affect elapsed time; the observed runtimes should not be interpreted as a controlled benchmark of computational cost without repeated runs under comparable conditions.

## 7. Interpretation

E2_500 demonstrates that the existing RetinaRegNet pipeline can be evaluated with half the baseline feature-point budget while retaining approximately 98.58% of baseline overall AUC.

The experiment shows a measurable accuracy reduction compared with the baseline, alongside a substantial reduction in observed elapsed runtime. However, the E2 runtime was slightly longer than E1_750, so the runtime results do not establish a strictly monotonic relationship between feature-point count and elapsed time.

The results support further investigation of the feature-point budget as a practical efficiency–accuracy parameter. The best operating point should be selected by considering both registration accuracy and computational cost, rather than AUC or runtime alone.

## 8. Limitations and considerations

1. The experiment changes the combined SIFT-plus-random feature-point budget proportionally. It does not isolate the individual effects of SIFT and random points.
2. The recorded runtime is from one execution per configuration. Repeated runs would be needed to estimate runtime variability reliably.
3. Category-specific AUC values for A and P are not included in this report because they were not available in the verified result summary.
4. The output directory size and number of files describe generated artifacts, not registration quality or computational efficiency.
5. A successful Slurm exit confirms script completion, not that every image pair achieved an accurate registration.

## 9. Reproducibility and archived files

The following E2_500 files were copied to the Windows archive:

```text
C:\\RetinaTradNet\\E2_500\\
├── Scripts\\
│   └── retinaregnet_fire_evaluation_E2_500.py
├── Slurm\\
│   ├── run_retinaregnet_fire_E2_scratch.slurm
│   ├── retinaregnet_fire_E2_3331655.out
│   └── retinaregnet_fire_E2_3331655.err
├── Results\\
└── Documentation\\
    └── E2_500_Experiment_Report.md
```

The generated 5.1 GB result directory was not copied to the Windows archive, consistent with the archiving approach used for E1_750. The original results remain on Roihu at:

```text
/scratch/project_2020210/RetinaTradNet/Experiments/E2_500
```

The Slurm script is configured for the CSC Roihu environment and should not be assumed to run unchanged on another HPC system.

## 10. Conclusion

E2_500 successfully completed the FIRE evaluation using 500 SIFT and 500 random feature points (1,000 total). It achieved an overall AUC of **0.888358**, retaining approximately **98.58%** of the baseline AUC, with an observed runtime of **02:29:11**. Compared with the baseline, this represents an approximately **35.2% reduction in elapsed runtime** and an approximately **1.28-percentage-point reduction in overall AUC**.

The experiment provides evidence that a lower feature-point budget can preserve much of the baseline registration accuracy. The slightly longer runtime compared with E1_750 highlights the need for repeated timing measurements before drawing firm conclusions about runtime scaling.
