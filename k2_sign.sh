source env.sh
source tcti.sh
source k2_header.sh
source test.sh
set -x

this_key_path=${key2_path}
this_key_name=${key2_name}

this_key_path=${key2_path}
this_key_ctx=${key2_ctx}
this_key_pub=${key2_pub}
this_key_priv=${key2_priv}

# case 1: Sign with the TPM and verify with OSSL
case1() {
    echo "my message" > ${dat}
    tpm2_sign ${tcti} -c ${this_key_ctx} -g sha256 -o ${sig} ${dat}
    tpm2_verifysignature ${tcti} -c ${this_key_ctx} -g sha256 -s ${sig} -m ${dat}
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
    tpm2_loadexternal ${tcti} -Q -G ecc -r ${open_priv_key} -c ${key_ctx}

    # Sign in the TPM and verify with OSSL
    set -x
    tpm2_sign ${tcti} -Q -c ${key_ctx} -g sha256 -d -f plain -o ${data_signed} ${data_digest}
    openssl dgst -verify ${open_pub_key} -keyform pem -sha256 -signature ${data_signed} ${data_plain}
}

case2