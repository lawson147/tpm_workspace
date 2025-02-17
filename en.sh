tpm_workspace=/home/lawsonzhang/tpm_workspace/

# primary key
parent_key_dir=${tpm_workspace}owner_lawsonzhang/
parent_key_ctx_simple_name=primary.ctx
parent_key_ctx=${parent_key_dir}${parent_key_ctx_simple_name}

# this key: key1
this_key_dir=${parent_key_dir}key1/
this_key_name=key1
this_key_priv=${this_key_dir}key1.priv
this_key_pub=${this_key_dir}key1.pub
this_key_ctx=${this_key_dir}key1.ctx

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
