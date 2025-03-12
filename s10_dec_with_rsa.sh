set -x

source env.sh
source tcti.sh
source duplicate_header.sh
source test.sh

# Decrypt using RSA
tpm2_rsadecrypt ${tcti} -c ${key4_ctx} -o ${dec} ${enc}
cat ${dec}