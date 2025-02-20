tpm_workspace=/home/lawsonzhang/tpm_workspace/tpm_keys/

# primary key path
parent_key_dir=owner_hierarchy/
parent_key_path=${tpm_workspace}${parent_key_dir}

# primary key
primary_key_dir=primary/
primary_key_path=${parent_key_path}

primary_key_name=primary
format=pem
primary_key_ctx=${primary_key_path}${primary_key_name}.ctx
primary_key_priv=${primary_key_path}${primary_key_name}.priv
primary_key_pub=${primary_key_path}${primary_key_name}.pub
cretificate=${primary_key_path}${primary_key_name}public.${format}