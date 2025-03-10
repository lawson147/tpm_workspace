# This key104 is a symmetry parent key for duplicating, under the primary key of lawson
set -x

source env_of_lawson.sh
source dup_to_header.sh

this_key_path=${key104_path}
this_key_name=${key104_name}

this_key_path=${key104_path}
this_key_ctx=${key104_ctx}
this_key_pub=${key104_pub}
this_key_priv=${key104_priv}


if [ ! -f ${lawson_primary_key_ctx} ]; then
    echo Create lawson_primary_key firstly please!
    exit 1
fi

if [ ! -d ${this_key_path} ]; then
    mkdir ${this_key_path}
fi


if [ ! -f ${this_key_priv} ]; then
    tpm2_create ${tcti} -C ${lawson_primary_key_ctx} -u ${this_key_pub} -r ${this_key_priv} -L policy.dat
else
    echo ${this_key_name} has been existed!
fi