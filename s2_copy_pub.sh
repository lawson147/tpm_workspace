set -x

source env_of_lawson.sh
source dup_to_header.sh

scp tpm_server:${key104_pub} ${key104_pub}