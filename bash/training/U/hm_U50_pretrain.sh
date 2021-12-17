#!/bin/bash

start=`date +%s`
# Allows for quick test runs - Set topk to e.g. 20 & midsave to 5
topk=${1:--1}
#$topk
# 50 Feats, Seed 43
# cp ./data/hm_vgattr5050.tsv ./data/HM_img.tsv

# Modified: Change num_features from 50 to 54
# --tr bert-large-cased -> roberta-large
# batchsize 16->8
# remove --num_pos 6 

# python pretrain_bertU.py --seed 126 --taskMaskLM --taskMatched --wordMaskRate 0.15 --train pretrain --tsv --tr bert-large-uncased-whole-word-masking \
# --batchSize 8 --lr 0.25e-5 --epochs 8 --num_features 50 --topk $topk
# --loadpre ./data/wwm_uncased_L-24_H-1024_A-16/bert_model.ckpt.data-00000-of-00001

python hm.py --seed 43 --model U \
--train train --valid dev_seen --test dev_seen --lr 1e-5 --batchSize 8 --tr bert-large-uncased-whole-word-masking --epochs 10 --tsv \
--num_features 50 --loadpre ./data/LAST_BU.pth --contrib --exp U50BunEpoch10 --topk $topk

python hm.py --seed 43 --model U \
--train traindev --valid dev_seen --test test_seen,test_unseen --lr 1e-5 --batchSize 8 --tr bert-large-uncased-whole-word-masking --epochs 10 --tsv \
--num_features 50 --loadpre ./data/LAST_BU.pth --contrib --exp U50BunEpoch10 --topk $topk

end=`date +%s`

runtime=$((end-start))

echo $runtime