set -x

source env.sh
source tcti.sh
source dup_source_header.sh
source test.sh


echo "my message" > ${dat}
tpm2_sign ${tcti} -c ${this_key_ctx} -g sha256 -o ${sig} ${dat}
tpm2_verifysignature ${tcti} -c ${this_key_ctx} -g sha256 -s ${sig} -m ${dat}