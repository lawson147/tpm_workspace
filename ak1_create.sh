set -x
source tcti.sh
source env.sh

# endorsment key
endorsement_key_dir=endorsement_lawsonzhang/
endorsement_key_path=${tpm_workspace}${endorsement_key_dir}

endorsement_key_name=ek
endorsement_key_ctx=${endorsement_key_path}${endorsement_key_name}.ctx
endorsement_key_pub=${endorsement_key_path}${endorsement_key_name}.pub

# this key: ak1
attestation_key_dir=ak1/
attestation_key_path=${tpm_workspace}${endorsement_key_dir}${attestation_key_dir}

attestation_key_name=ak
attestation_key_ctx=${attestation_key_path}${attestation_key_name}.ctx
attestation_key_pub=${attestation_key_path}${attestation_key_name}.pub


# Check directory
if [ ! -d ${attestation_key_path} ]; then
    mkdir ${attestation_key_path}
fi

# Create ak
if [ -f ${attestation_key_ctx} ]; then
    tpm2_createak ${tcti} -C ${endorsement_key_ctx} -c ${attestation_key_ctx} -u ${attestation_key_pub} -s rsassa -p akpass -n ak.name > ak.out

    file_size=`ls -l ak.name | awk {'print $5'}`
    # loaded_key_name=`cat ak.name | xxd -p -c $file_size`

    # tpm2 readpublic -c 0x81010009 -o ek.pem -f pem -Q

    # echo "12345678" | tpm2 makecredential -Q -u ek.pem -s - -n $loaded_key_name -o mkcred.out -G rsa
else
    echo ${attestation_key_name} has been existed!
fi
