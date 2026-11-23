# E1_750 Experiment Report

## 1. Experiment identification

-   **Project:** RetinaTradNet, based on the original RetinaRegNet
    implementation
-   **Experiment:** E1_750
-   **Research focus:** Trade-off between computational efficiency and
    registration accuracy through feature-point budget reduction
-   **Dataset:** FIRE retinal image registration dataset
-   **Experiment date:** 22 November 2026
-   **Slurm job ID:** `3327740`
-   **Execution status:** `COMPLETED`, exit code `0:0`

## 2. Research objective

E1 investigates how reducing the feature-point budget in the existing
RetinaRegNet pipeline affects retinal image registration accuracy and
computational efficiency.

The SIFT and random feature-point budgets are reduced proportionally.
This experiment does **not** independently isolate the contribution of
SIFT points from random points.

## 3. Feature-point configuration

  Configuration     SIFT points   Random points   Total
  --------------- ------------- --------------- -------
  Baseline                1,000           1,000   2,000
  E1_750                    750             750   1,500

E1 uses 25% fewer requested feature points than the baseline.

## 4. Fixed pipeline configuration

  Parameter                                    Setting
  -------------------------------------------- --------------------------------
  Registration framework                       Original RetinaRegNet pipeline
  Stable Diffusion model                       Stable Diffusion 2.1
  Image size                                   920
  Ensemble size                                8
  Diffusion timestep                           1
  Upsampling index                             2
  Stage 1 transformation                       Homography
  Stage 2 transformation                       Third-order polynomial
  Stage 1 affine outlier rejection threshold   25
  Stage 2 affine outlier rejection threshold   15
  Dataset categories                           FIRE A, P and S

The intended comparison changes the feature-point budget while retaining
the other listed pipeline settings.

## 5. Computing environment and Slurm allocation

  Item                Recorded setting
  ------------------- --------------------
  HPC system          CSC Roihu
  Partition           `gpumedium`
  Compute node        `rg1103`
  GPU                 NVIDIA GH200 120GB
  GPUs allocated      1
  CPUs allocated      8
  Memory allocated    217,086 MB
  Slurm time limit    36 hours
  Python              3.12.12
  PyTorch             2.10.0+cu130
  CUDA availability   True
  Slurm job ID        `3327740`

Slurm accounting reported an elapsed time of **02:24:38**, state
`COMPLETED`, and exit code `0:0`.

## 6. Results

### 6.1 Overall AUC

  Experiment     Total requested points   Overall AUC
  ------------ ------------------------ -------------
  Baseline                        2,000      0.901194
  E1_750                          1,500      0.896418

Absolute AUC difference:

`0.901194 - 0.896418 = 0.004776`

This is approximately a **0.48 percentage-point reduction** when AUC
values are expressed as percentages. E1 retains approximately **99.47%
of the baseline AUC value** (0.896418 divided by 0.901194).

### 6.2 Additional reported values

-   E1 S-class AUC: `0.952676`
-   Case 70 landmark error before registration: `259.5695 px`
-   Case 70 landmark error after registration: `2.8783 px`

Case 70 is an individual example, not an aggregate accuracy measure.

### 6.3 Runtime comparison

  Experiment      Runtime
  ------------ ----------
  Baseline       03:50:03
  E1_750         02:24:38

E1 used approximately **37.1% less elapsed time** than the baseline.
This is an observed difference between the recorded runs; run-to-run
variability and HPC scheduling conditions can affect elapsed time.

### 6.4 Output record

The E1 output directory on scratch occupied approximately **5.1 GB** and
contained **1,210 files** when checked after completion. Generated
registration outputs were intentionally not copied into this Windows
archive; they can be regenerated if the required dataset, model weights,
software environment and input files remain available.

## 7. AUC evaluation definition

The evaluation script computes success rates over landmark-error
thresholds from 0 through 25 pixels. A failed registration is assigned a
sentinel landmark error of `10000`, which does not pass these
thresholds. The AUC is calculated from the success-rate values across
the threshold range using the implementation in the evaluation script.

Preserve the original evaluation implementation when reproducing the
comparison.

## 8. Reproducibility and archive contents

Windows archive location:

`C:\RetinaTradNet\E1_750\`

Expected contents:

-   `Scripts\retinaregnet_fire_evaluation_mirror.py` --- E1 Python
    evaluation script copied from Roihu.
-   `Slurm\run_retinaregnet_fire_E1_scratch.slurm` --- Slurm submission
    script used for the scratch-based run.
-   `Slurm\retinaregnet_fire_E1_3327740.out` --- standard output log.
-   `Slurm\retinaregnet_fire_E1_3327740.err` --- standard error log.
-   `Documentation\E1_750_Experiment_Report.md` --- this report.

The archived Slurm script contains Roihu-specific paths and environment
assumptions. It documents the successful run; it is not a portable job
script for another HPC system or directory layout.

For reproduction, retain access to: 1. The FIRE dataset in the expected
project location. 2. Stable Diffusion 2.1 model weights and the required
Hugging Face cache. 3. A compatible Python/PyTorch environment and
dependencies. 4. The original RetinaRegNet source files used by the
mirror script. 5. The same evaluation settings and input data.

Consult the run logs for warnings and diagnostic messages. A successful
Slurm exit code confirms job completion, but does not by itself
establish registration quality.

## 9. Interpretation and next experiments

E1 reduced the requested feature-point budget by 25% and completed in
02:24:38, compared with 03:50:03 for the baseline. Its overall AUC was
lower by 0.004776.

This is preliminary evidence of a possible efficiency--accuracy
trade-off. It is not sufficient on its own to identify the optimal
feature-point budget.

The planned experiment series is:

  Experiment     SIFT points   Random points   Total
  ------------ ------------- --------------- -------
  Baseline             1,000           1,000   2,000
  E1_750                 750             750   1,500
  E2_500                 500             500   1,000
  E3_250                 250             250     500

E2 and E3 should use the same dataset, pipeline settings, evaluation
procedure and comparable computing conditions. The final conclusion
should consider AUC, landmark-error metrics, completion rate and runtime
together.

------------------------------------------------------------------------

**Record status:** E1 completed; code and Slurm logs archived on
Windows. Generated registration outputs were intentionally not copied.
