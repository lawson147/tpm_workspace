# This key2_sign is a asymmetric key to sign some data, under the primary key
source env.sh
source key3_header.sh

if [ ! -f ${primary_key_ctx} ]; then
    echo Create primary_key firstly please!
    exit 1
fi

if [ ! -d ${this_key_path} ]; then
    mkdir -p ${this_key_path}
fi

if [ ! -f ${this_key_priv} ]; then
    tpm2_create -C ${primary_key_ctx} -G rsa -u ${this_key_pub} -r ${this_key_priv}
else
    echo ${this_key_name} has been existed!
fi