set -x
source env.sh
source env_of_lawson.sh
source tcti.sh
source dup_source_header.sh
source dup_to_header.sh

ssh tpm_server "mkdir -p ${key4_path}"
scp -r ${key4_path}dup.dpriv tpm_server:${key4_path}dup.dpriv
scp -r ${key4_path}dup.seed tpm_server:${key4_path}dup.seed