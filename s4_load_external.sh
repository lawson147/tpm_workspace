set -x

source env_of_lawson.sh
source tcti.sh
source dup_to_header.sh

tpm2_loadexternal ${tcti} -C o -u ${key104_pub} -c ${key104_ctx}