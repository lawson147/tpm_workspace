source env.sh
set -x
source tcti.sh

# if [ ! -d ${primary_key_path} ]; then
#     mkdir -p ${primary_key_path}
# fi

# if [ ! -f ${primary_key_ctx} ]; then
    tpm2_createprimary ${tcti} -c ${primary_key_ctx} -f ${format} -o ${cretificate}
# else
    # echo ${primary_key_name} has been existed!
# fi