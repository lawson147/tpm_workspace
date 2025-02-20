source env.sh

if [ ! -d ${primary_key_path} ]; then
    mkdir -p ${primary_key_path}
fi

if [ ! -f ${primary_key_ctx} ]; then
    set -x
    tpm2_createprimary -c ${primary_key_ctx} -f ${format} -o ${cretificate}
    set +x
else
    echo ${primary_key_name} has been existed!
fi