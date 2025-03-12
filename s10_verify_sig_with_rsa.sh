set -x
source env.sh
source tcti.sh
source duplicate_header.sh
source test.sh

tpm2_verifysignature ${tcti} -c ${key4_ctx} -g sha256 -s ${sig} -m ${dat}