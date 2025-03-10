source env.sh
source tcti.sh
source duplicate_header.sh

set -x

# redundant
# if [ ! -d ${primary_key_path} ]; then
#     mkdir -p ${primary_key_path}
# fi

# if [ ! -f ${primary_key_ctx} ]; then
#     set -x
#     tpm2_createprimary ${tcti} -c ${primary_key_ctx} -f ${format} -o ${cretificate}
#     set +x
# else
#     echo ${primary_key_name} has been existed!
# fi

# if [ $1 == 1 ]; then
#     tpm2_startauthsession ${tcti} -S session.dat
#     tpm2_policycommandcode ${tcti} -S session.dat -L policy.dat TPM2_CC ${tcti}_Duplicate
#     tpm2_flushcontext ${tcti} session.dat
#     exit 0
# fi
# tpm2_createprimary ${tcti} -C o -g sha256 -G rsa -c primary.ctxt
# tpm2_create ${tcti} -C primary.ctxt -g sha256 -G rsa -r key.prv -u key.pub \
# -L policy.dat -a "sensitivedataorigin"

# tpm2_loadexternal ${tcti} -C o -u new_parent.pub -c new_parent.ctxt

# if [ $1 == 2 ]; then
#     tpm2_startauthsession ${tcti} --policy-session -S session.dat
#     tpm2_policycommandcode ${tcti} -S session.dat -L policy.dat TPM2_CC ${tcti}_Duplicate
#     tpm2_duplicate ${tcti} -C ${from_context} -c ${to_context} -G null -p "session:session.dat" -r duprv.bin -s seed.dat
#     tpm2_flushcontext ${tcti} session.dat
# fi

if [ ! -d ${key104_path} ]; then
    mkdir -p ${key104_path}
fi


if [ $1 == 1 ]; then
    tpm2_create ${tcti}  -C ${lawson_primary_key_ctx} -g sha256 -G rsa \
    -r ${key104_priv}  -u ${key104_pub} \
    -a "restricted|sensitivedataorigin|decrypt|userwithauth"
    exit 0
fi

# copy to key4
if [ $1 == 2 ]; then
    cp ${key104_pub} ${key4_path}
    exit 0
fi

if [ $1 == 3 ]; then
    tpm2_startauthsession ${tcti} -S ${key4_path}session.dat
    tpm2_policycommandcode ${tcti} -S ${key4_path}session.dat -L ${key4_path}dpolicy.dat TPM2_CC_Duplicate
    ls -l ${key4_path}session.dat | awk '{print $5}'
    tpm2_flushcontext ${tcti} ${key4_path}session.dat
    rm ${key4_path}session.dat
fi

if [ $1 == 4 ]; then
    tpm2_startauthsession ${tcti} --policy-session -S ${key4_path}session.dat
    tpm2_policycommandcode ${tcti} -S ${key4_path}session.dat -L ${key4_path}dpolicy.dat TPM2_CC_Duplicate
    tpm2_loadexternal ${tcti} -C o -u ${key4_path}key104.pub -c ${key4_path}key104.ctx
    exit 1
fi

# to duplicate
if [ $1 == 5 ];then
    tpm2_duplicate ${tcti} -C ${key4_path}key104.ctx -c ${key4_ctx} -G null  \
    -p "session:${key4_path}session.dat" -r ${key4_path}dup.dpriv -s ${key4_path}dup.seed
    exit 1
fi

# copy to 104
if [ $1 == 6 ];then
    mv ${key4_path}dup.pub ${key4_path}dup.dpriv ${key4_path}dup.seed ${key104_path}
    exit 1
fi

# import new ctx
if [ $1 == 7 ];then
    # auth
    tpm2_startauthsession ${tcti} --policy-session -S session.dat
    tpm2_policycommandcode ${tcti} -S session.dat -L ${key104_path}dpolicy.dat TPM2_CC ${tcti}_Duplicate
    tpm2_flushcontext ${tcti} --transient-object

    # import
    tpm2_load ${tcti} -C ${lawson_primary_key_ctx} -u ${key104_pub} -r ${key104_priv} -c ${key104_ctx}
    tpm2_import ${tcti} -C ${key104_ctx} -u ${key104_path}dup.pub -i ${key104_path}dup.dpriv \
    -r ${key104_path}dup.prv -s ${key104_path}dup.seed -L ${key104_path}dpolicy.dat
    tpm2_flushcontext ${tcti} --transient-object

    # for use    
    tpm2_load ${tcti} -C ${key104_ctx} -u ${key104_path}dup.pub -r ${key104_path}dup.prv -c ${key104_path}dup.ctx
    tpm2_readpublic ${tcti} -c ${key104_path}dup.ctx -o ${parent_key_path}dup.pub
    exit 1
fi