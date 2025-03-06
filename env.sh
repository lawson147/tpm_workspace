tpm_workspace=/home/lawsonzhang/tpm_workspace/keys/

# primary key path
parent_key_dir=primary_hierarchy/
parent_key_path=${tpm_workspace}${parent_key_dir}

# primary key
primary_key_dir=primary/
primary_key_path=${parent_key_path}

primary_key_name=primary
format=pem
primary_key_ctx=${primary_key_path}${primary_key_name}.ctx
primary_key_priv=${primary_key_path}${primary_key_name}.priv
primary_key_pub=${primary_key_path}${primary_key_name}.pub
cretificate=${primary_key_path}${primary_key_name}_public.${format}