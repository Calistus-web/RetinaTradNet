#!/bin/bash
#SBATCH --job-name=RetinaTradNet_E1_750
#SBATCH --account=project_2020210
#SBATCH --partition=gpumedium
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:gh200:1
#SBATCH --time=36:00:00
#SBATCH --output=/scratch/project_2020210/RetinaTradNet/slurm_log/retinaregnet_fire_E1_%j.out
#SBATCH --error=/scratch/project_2020210/RetinaTradNet/slurm_log/retinaregnet_fire_E1_%j.err

set -euo pipefail

SCRATCH="/scratch/project_2020210/RetinaTradNet"

export RETINATRADNET_OUTPUT_ROOT="$SCRATCH/Experiments/E1_750"
export RETINATRADNET_TMPDIR="$SCRATCH/tmp/E1_750_processing"
export TMPDIR="$SCRATCH/tmp/job_tmp"
export MPLCONFIGDIR="$SCRATCH/mplconfig"

mkdir -p "$RETINATRADNET_OUTPUT_ROOT" "$RETINATRADNET_TMPDIR" "$MPLCONFIGDIR"

echo "=========================================="
echo "RetinaRegNet FIRE E1 evaluation"
echo "Job ID: $SLURM_JOB_ID"
echo "Started: $(date)"
echo "Node: $(hostname)"
echo "Results: $RETINATRADNET_OUTPUT_ROOT"
echo "Temporary files: $RETINATRADNET_TMPDIR"
echo "=========================================="

cd "$HOME/RetinaTradNet/original_RetinaRegNet"

module load python-pytorch/2.10
source .venv_gpu/bin/activate

export HF_HOME="$HOME/.cache/huggingface"
export MPLBACKEND=Agg
export OMP_NUM_THREADS="$SLURM_CPUS_PER_TASK"
export MKL_NUM_THREADS="$SLURM_CPUS_PER_TASK"

echo "Python:"
python --version

echo "PyTorch and GPU:"
python -c "import torch; print('PyTorch:', torch.__version__); print('CUDA:', torch.cuda.is_available()); print('GPU:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'Not available')"

echo "Starting complete FIRE evaluation..."

python -u "Scripts/Python Scripts/retinaregnet_fire_evaluation_mirror.py"

echo "=========================================="
echo "RetinaRegNet E1 evaluation completed successfully."
echo "Finished: $(date)"
echo "=========================================="
