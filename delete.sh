source env.sh
source k1_header.sh
source k2_header.sh
source k3_header.sh
source dup_source_header.sh

set -- 4

if [ $1 -gt 0 ] && [ $1 -lt 6 ]; then
    target=key"$1"_key_path
    rm ${!target} -rf
fi