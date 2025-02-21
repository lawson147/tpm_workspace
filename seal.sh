set -x

source env.sh

seal_ctx=seal.ctx

tpm2_pcrread -o pcr.bin sha256:0,1,2,3
tpm2_createpolicy --policy-pcr -l sha256:0,1,2,3 -f pcr.bin -L pcr.policy

# Form stdio
# echo 'hello chengdu' | tpm2_create -C ${primary_key_ctx} -L pcr.policy -i- -u seal.pub -r seal.priv -c ${seal_ctx}

# From file
blob_input_name=test1gb.blob
blob_output_name=test1gb.out.blob

dd if=/dev/zero of=${blob_input_name} bs=1K count=1
truncate -s 127 ${blob_input_name}

tpm2_create -C ${primary_key_ctx} -L pcr.policy -i ${blob_input_name} -u seal.pub -r seal.priv -c ${seal_ctx}
tpm2_unseal -c ${seal_ctx} -p pcr:sha256:0,1,2,3 -o ${blob_output_name}