set -x

source env.sh
source tcti.sh
source dup_source_header.sh
source test.sh

# by the way, encrypt something with it
# Encrypt using RSA
echo "Hello RSA" > ${msg}
tpm2_rsaencrypt ${tcti} -c ${key4_ctx} -o ${enc} ${msg}