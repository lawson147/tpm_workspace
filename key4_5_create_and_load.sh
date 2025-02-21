# attribution="fixedtpm|fixedparent|restricted|decrypt|sensitivedataorigin|userwithauth" # the right storage key attribution configuration
# attribution="fixedtpm|fixedparent|sensitivedataorigin|userwithauth|decrypt|sign" # can be created but can't be loaded

sub="|sensitivedataorigin|userwithauth"
attribution="restricted|decrypt"${sub} # testing

source env.sh
source key4_5_header.sh

if [ ! -f ${primary_key_ctx} ]; then
    echo Create primary_key firstly please!
    exit 1
fi

if [ ! -d ${parent_key_path} ]; then
    mkdir -p ${parent_key_path}
fi

if [ ! -f ${parent_key_priv} ]; then
    set -x
    tpm2_create -C ${primary_key_ctx} -G rsa -u ${parent_key_pub} -r ${parent_key_priv} -a ${attribution}
    set +x

    tpm2_load -C ${primary_key_ctx} -u ${parent_key_pub} -r ${parent_key_priv} -c ${parent_key_ctx}
    
    mkdir -p ${child_key_path}
    tpm2_create -C ${parent_key_ctx} -G aes -u ${child_key_pub} -r ${child_key_priv} -a ${attribution}
    tpm2_load -C ${parent_key_ctx} -u ${child_key_pub} -r ${child_key_priv} -c ${child_key_ctx}
else
    echo ${parent_key_name} has been existed!
fi