# This key1_sym is a symmetry key, under the primary key
set -x
source env.sh
source tcti.sh
source k1_header.sh

this_key_path=${key1_path}
this_key_name=${key1_name}

this_key_path=${key1_path}
this_key_ctx=${key1_ctx}
this_key_pub=${key1_pub}
this_key_priv=${key1_priv}

if [ ! -f ${primary_key_ctx} ]; then
    echo Create primary_key firstly please!
    exit 1
fi

if [ ! -d ${this_key_path} ]; then
    mkdir ${this_key_path}
fi


# if [ ! -f ${this_key_priv} ]; then
    tpm2_create ${tcti} -C ${primary_key_ctx} -G aes128 -u ${this_key_pub} -r ${this_key_priv}
# else
    # echo ${this_key_name} has been existed!
# fi
