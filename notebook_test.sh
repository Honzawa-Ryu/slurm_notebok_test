#!/bin/bash
#SBATCH --job-name=jupyter_lab
#SBATCH --partition=interactive
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --output=%j_jupyter.log

PORT=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "$PORT"

apptainer exec --nv testenv.sif \
    bash -c "source .venv/bin/activate && jupyter lab --ip=0.0.0.0 --port=$PORT --no-browser --allow-root"