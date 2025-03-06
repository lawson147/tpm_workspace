# attribution="fixedtpm|fixedparent|restricted|decrypt|sensitivedataorigin|userwithauth" # the right storage key attribution configuration
# attribution="fixedtpm|fixedparent|sensitivedataorigin|userwithauth|decrypt|sign" # can be created but can't be loaded

sub="|sensitivedataorigin|userwithauth"
attribution="restricted|decrypt"${sub} # testing

attribution_for_duplication="sensitivedataorigin|userwithauth|decrypt|sign"

source env.sh
source key4_5_header.sh

parent_key_path=${key4_path}
parent_key_name=${key4_name}
parent_key_path=${key4_path}
parent_key_ctx=${key4_ctx}
parent_key_pub=${key4_pub}
parent_key_priv=${key4_priv}

child_key_path=${key5_path}
child_key_name=${key5_name}
child_key_path=${key5_path}
child_key_ctx=${key5_ctx}
child_key_pub=${key5_pub}
child_key_priv=${key5_priv}

if [ ! -f ${primary_key_ctx} ]; then
    echo Create primary_key firstly please!
    exit 1
fi

if [ ! -d ${parent_key_path} ]; then
    mkdir -p ${parent_key_path}
fi

if [ ! -f ${parent_key_priv} ]; then
    set -x
    # normal
    # tpm2_create ${tcti} -C ${primary_key_ctx} -G rsa -u ${parent_key_pub} -r ${parent_key_priv} -a ${attribution}

    # for duplication
    tpm2_create ${tcti} -C ${primary_key_ctx} -G rsa -u ${parent_key_pub} -r ${parent_key_priv} -L ${parent_key_path}dpolicy.dat -a ${attribution_for_duplication}
    tpm2_load ${tcti} -C ${primary_key_ctx} -u ${parent_key_pub} -r ${parent_key_priv} -c ${parent_key_ctx}
    tpm2_readpublic ${tcti} -c ${parent_key_ctx} -o ${parent_key_path}dup.pub
    
    # mkdir -p ${child_key_path}
    # tpm2_create ${tcti} -C ${parent_key_ctx} -G rsa -u ${child_key_pub} -r ${child_key_priv} -a ${attribution_for_duplication}
    # tpm2_load ${tcti} -C ${parent_key_ctx} -u ${child_key_pub} -r ${child_key_priv} -c ${child_key_ctx}
else
    rm ${key4_path}/*
    echo please rerun to recreate ${parent_key_name}!
fi