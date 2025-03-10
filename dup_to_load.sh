# This key104 is a symmetry 
set -x

source env_of_lawson.sh
source dup_to_header.sh

this_key_path=${key104_path}
this_key_name=${key104_name}

this_key_path=${key104_path}
this_key_ctx=${key104_ctx}
this_key_pub=${key104_pub}
this_key_priv=${key104_priv}
# This key104 is a symmetry 
set -x

source env_of_lawson.sh
source key104_header.sh

this_key_path=${key104_path}
this_key_name=${key104_name}

this_key_path=${key104_path}
this_key_ctx=${key104_ctx}
this_key_pub=${key104_pub}
this_key_priv=${key104_priv}

# Check directory
if [ ! -d ${this_key_path} ]; then
    echo You have no this dictionary: ${this_key_path}
    exit 1
fi

# Check priv and pub
if [ ! -f ${this_key_priv} ]; then
    echo echo You have no ${this_key_name}.priv
    exit 1
fi

if [ ! -f ${this_key_pub} ]; then
    echo echo You have no ${this_key_name}.pub
    exit 1
fi

# Load this key
if [ ! -f ${this_key_ctx} ]; then
    tpm2_load ${tcti} -C ${lawson_primary_key_ctx} -u ${this_key_pub} -r ${this_key_priv} -c ${this_key_ctx}
else
    echo ${this_key_name} has been loaded!
fi