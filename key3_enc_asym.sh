source env.sh
source key3_header.sh

plain_pre=msg.dat
plain_after=msg_after.dat
cipher_txt=msg.enc

case1() {
    rm ${plain_pre}
    rm ${plain_after}
    rm ${cipher_txt}

    # Encrypt using RSA
    echo "Hello RSA" > ${plain_pre}
    tpm2_rsaencrypt -c ${this_key_ctx} -o ${cipher_txt} ${plain_pre}

    # Decrypt using RSA
    tpm2_rsadecrypt -c ${this_key_ctx} -o ${plain_after} ${cipher_txt}
    cat ${plain_after}
}

case1