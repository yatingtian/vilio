#!/bin/bash

# Allows for not having to copy the models to vilio/data
loadfin=${1:-./data/LASTtrain.pth}
loadfin2=${2:-./data/LASTtraindev.pth}

# Roberta

# 50 Feats, Seed 43
# cp ./data/hm_vgattr5050.tsv ./data/HM_img.tsv

# python hm.py --seed 43 --model U \
# --test dev_unseen --lr 1e-5 --batchSize 8 --tr roberta-large --epochs 5 --tsv \
# --num_features 50 --num_pos 6 --loadfin $loadfin --exp U43R50

python hm.py --seed 43 --model U \
--test test_unseen --lr 1e-5 --batchSize 8 --tr roberta-large --epochs 5 --tsv \
--num_features 50 --num_pos 6 --loadfin $loadfin --exp U43R50
