tpm_workspace=/home/lawsonzhang/tpm_workspace/

# primary key
parent_key_dir=${tpm_workspace}owner_lawsonzhang/
parent_key_ctx_simple_name=primary.ctx
parent_key_ctx=${parent_key_dir}${parent_key_ctx_simple_name}

# this key: key1
this_key_dir=${parent_key_dir}key1/
this_key_name=key1
this_key_priv=${this_key_dir}key1.priv
this_key_pub=${this_key_dir}key1.pub
this_key_ctx=${this_key_dir}key1.ctx

# Check directory
cd $parent_key_dir
if [ ! -d ${this_key_dir} ]; then
    echo You have no this dictionary: ${this_key_dir}
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
if [ ! -f ${this_key_name}.priv ]; then
    tpm2_load -C ${parent_key_ctx} -u ${this_key_pub} -r ${this_key_priv} -c ${this_key_ctx}
else
    echo ${this_key_name} has been existed!
fi