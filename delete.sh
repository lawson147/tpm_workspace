source env.sh
source key1_header.sh
source key2_header.sh
source key3_header.sh
source key4_5_header.sh

set -- 4

if [ $1 -gt 0 ] && [ $1 -lt 6 ]; then
    target=key"$1"_key_path
    rm ${!target} -rf
fi