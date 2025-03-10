set -x

source env_of_lawson.sh
source dup_to_header.sh

mkdir -p ${key104_path}
scp -r tpm_server:${key104_pub} ${key104_pub}