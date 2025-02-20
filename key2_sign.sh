source env.sh
source key2_header.sh

# case 1: Sign with the TPM and verify with OSSL
case1() {
    # related files
    plain=message.dat
    sig=sig.rssa

    rm ${plain}
    rm ${sig}

    echo "my message" >message.dat
    set -x
    tpm2_sign -c ${this_key_ctx} -g sha256 -o ${sig} ${plain}
    tpm2_verifysignature -c ${this_key_ctx} -g sha256 -s ${sig} -m ${plain}
    set +x
}

# case 2: Sign with the TPM and verify with OSSL
case2() {
    open_pub_key=public.ecc.pem
    open_priv_key=private.ecc.pem
    data_plain=data.in.raw
    data_digest=data.in.digest
    key_ctx=key.ctx
    data_signed=data.out.signed

    # Firstly create private key and extract public key
    openssl ecparam -name prime256v1 -genkey -noout -out ${open_priv_key}
    openssl ec -in ${open_priv_key} -out ${open_pub_key} -pubout

    # Secondly generate a hash to sign
    echo "data to sign" > ${data_plain}
    sha256sum ${data_plain} | awk '{ print "000000 " $1 }' | xxd -r -c 32 > ${data_digest}

    # Thirdly load the private key from the external for signing
    tpm2_loadexternal -Q -G ecc -r ${open_priv_key} -c ${key_ctx}

    # Sign in the TPM and verify with OSSL
    set -x
    tpm2_sign -Q -c ${key_ctx} -g sha256 -d -f plain -o ${data_signed} ${data_digest}
    openssl dgst -verify ${open_pub_key} -keyform pem -sha256 -signature ${data_signed} ${data_plain}
}

case2