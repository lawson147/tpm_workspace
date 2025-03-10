source env.sh
source tcti.sh
source k2_header.sh

this_key_path=${key2_path}
this_key_name=${key2_name}

this_key_path=${key2_path}
this_key_ctx=${key2_ctx}
this_key_pub=${key2_pub}
this_key_priv=${key2_priv}

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
    tpm2_load ${tcti} -C ${primary_key_ctx} -u ${this_key_pub} -r ${this_key_priv} -c ${this_key_ctx}
else
    echo ${this_key_name} has been loaded!
fi