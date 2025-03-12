source env.sh
source tcti.sh
source k3_header.sh
source test.sh

this_key_path=${key3_path}
this_key_name=${key3_name}

this_key_path=${key3_path}
this_key_ctx=${key3_ctx}
this_key_pub=${key3_pub}
this_key_priv=${key3_priv}

case1() {
    rm ${plain_pre}
    rm ${plain_after}
    rm ${cipher}

    # Encrypt using RSA
    echo "Hello RSA" > ${plain_pre}
    tpm2_rsaencrypt ${tcti} -c ${this_key_ctx} -o ${cipher} ${plain_pre}

    # Decrypt using RSA
    tpm2_rsadecrypt ${tcti} -c ${this_key_ctx} -o ${plain_after} ${cipher}
    cat ${plain_after}
}

case1