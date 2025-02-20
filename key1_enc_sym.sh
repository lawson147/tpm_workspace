source env.sh
source key1_header.sh

# related files
plain=secret.txt
enc=secret.enc
dec=secret.dec

# clear privious files
rm secret.*

# Prepare and do it
echo "Hello World" > secret.txt

tpm2_encryptdecrypt -c ${this_key_ctx} -o ${enc} ${plain}
tpm2_encryptdecrypt -d -c ${this_key_ctx} -o ${dec} ${enc}
cat ${dec}