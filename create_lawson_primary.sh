source env_of_lawson.sh

if [ ! -d ${lawson_primary_key_path} ]; then
    mkdir -p ${lawson_primary_key_path}
fi

if [ ! -f ${lawson_primary_key_ctx} ]; then
    set -x
    tpm2_createprimary -c ${lawson_primary_key_ctx} -f ${format} -o ${cretificate}
    set +x
else
    echo ${lawson_primary_key_name} has been existed!
fi