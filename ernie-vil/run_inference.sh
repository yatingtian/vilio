set -eu

#bash -x ./env.sh

TASK_NAME=$1
SUB_TASK_NAME=$2
TEST_SPLIT=$3
CONF_FILE=$4
VOCAB_PATH=$5
ERNIE_VIL_CONFIG=$6
MODEL_PATH=$7
RES_FILE=$8
SPLIT=$9
EXP=${10}
COMB=${11}
EPOCH=5 # modified

source $CONF_FILE

#configure your cuda and cudnn
#configure nccl

export FLAGS_eager_delete_tensor_gb=2.0
export FLAGS_fraction_of_gpu_memory_to_use=0.01
export FLAGS_sync_nccl_allreduce=1

e_executor=$(echo ${use_experimental_executor-'True'} | tr '[A-Z]' '[a-z]')

use_fuse=$(echo ${use_fuse-'False'} | tr '[A-Z]' '[a-z]')
if [[ ${use_fuse} == "true" ]]; then
    export FLAGS_fuse_parameter_memory_size=131072
    export FLAGS_fuse_parameter_groups_size=10
fi

TASK_GROUP_JSON=./conf/$TASK_NAME/task_${TASK_NAME}.json 
#_${SUB_TASK_NAME}.json

python finetune.py --use_cuda "True"                                           \
                --use_fast_executor ${e_executor-"True"}                       \
                --batch_size ${BATCH_SIZE}                                     \
                --do_train "False"                                             \
                --do_test "True"                                               \
                --test_split ${TEST_SPLIT}                                     \
                --task_name $TASK_NAME                                         \
                --vocab_path ${VOCAB_PATH}                                     \
                --task_group_json ${TASK_GROUP_JSON}                           \
                --result_file "$RES_FILE"                                      \
                --init_checkpoint "$MODEL_PATH"                                \
                --ernie_config_path ${ERNIE_VIL_CONFIG}                        \
                --max_seq_len ${MAX_LEN}                                       \
                --skip_steps 10                                                \
                --split ${SPLIT}                                               \
                --exp ${EXP}                                                   \
                --combine ${COMB}                                              \
                --epoch ${EPOCH}


