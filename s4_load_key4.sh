set -x

source env.sh
source tcti.sh
source dup_source_header.sh

tpm2_load ${tcti} -C ${primary_key_ctx} -u ${key4_pub} -r ${key4_priv} -c ${key4_ctx}