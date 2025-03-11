set -x

source env.sh
source tcti.sh
source dup_source_header.sh

tpm2_load ${tcti} -C ${primary_key_ctx} -u ${key4_pub} -r ${key4_priv} -c ${key4_ctx}

# by the way, encrypt something with it
plain_pre=msg.dat
plain_after=msg.dec
cipher_txt=msg.enc

# Encrypt using RSA
echo "Hello RSA" > ${plain_pre}
tpm2_rsaencrypt ${tcti} -c ${key4_ctx} -o ${cipher_txt} ${plain_pre}