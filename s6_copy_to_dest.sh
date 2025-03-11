set -x
source env.sh
source env_of_lawson.sh
source tcti.sh
source dup_source_header.sh
source dup_to_header.sh


tpm2_startauthsession \--policy-session -S session.dat
tpm2_policycommandcode -S session.dat -L policy.dat TPM2_CC_Duplicate


scp -r trusted:222:${key4_path}dup.dpriv ${key4_path}dup.dpriv
scp -r trusted:222:${key4_path}dup.seed ${key4_path}dup.seed