set -x
source env.sh
source env_of_lawson.sh
source tcti.sh
source dup_source_header.sh
source dup_to_header.sh


tpm2_startauthsession \--policy-session -S session.dat
tpm2_policycommandcode -S session.dat -L policy.dat TPM2_CC_Duplicate
tpm2_duplicate ${tcti} -C ${key104_ctx} -c ${key4_ctx} -G null -r ${key4_path}dup.dpriv -s ${key4_path}dup.seed -p "session:session.dat"
tpm2_flushcontext session.dat