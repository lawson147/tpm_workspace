parent_key_dir=/home/lawsonzhang/tpm_workspace/owner_lawsonzhang/
parent_key_ctx=primary.ctx

# As possible to make these two variable be the same name 
this_key_dir=key1/
this_key_name=key1

this_key_pub_file=${this_key_dir}.ctx

cd $parent_key_dir
if [ ! -d ${this_key_dir} ]; then
    mkdir ${this_key_dir}
fi
cd ${this_key_dir}

if [ ! -f ${this_key_name}.priv ]; then
    tpm2_create -C ${parent_key_dir}primary.ctx -G aes128 -u ${this_key_name}.pub -r ${this_key_name}.priv
else
    echo ${this_key_name} has been existed!
fi