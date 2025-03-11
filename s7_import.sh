set -x

source env.sh
source tcti.sh
source duplicate_header.sh    
    
tpm2_startauthsession ${tcti} --policy-session -S session.dat
tpm2_policycommandcode ${tcti} -S session.dat -L dpolicy.dat TPM2_CC_Duplicate
# tpm2_flushcontext ${tcti} --transient-object
tpm2_flushcontext ${tcti} session.dat

# import
tpm2_load ${tcti} -C ${lawson_primary_key_ctx} -u ${key104_pub} -r ${key104_priv} -c ${key104_ctx}
tpm2_import ${tcti} -C ${key104_ctx} -u ${key4_path}dup.pub -i ${key4_path}dup.dpriv \
-r ${key4_path}dup.prv -s ${key4_path}dup.seed -L dpolicy.dat
tpm2_flushcontext ${tcti} --transient-object

# for use    
tpm2_load ${tcti} -C ${key104_ctx} -u ${key104_path}dup.pub -r ${key104_path}dup.prv -c ${key104_path}dup.ctx
tpm2_readpublic ${tcti} -c ${key104_path}dup.ctx -o ${parent_key_path}dup.pub
exit 1