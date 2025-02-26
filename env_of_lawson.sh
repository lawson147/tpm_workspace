tpm_workspace=/home/lawsonzhang/tpm_workspace/keys/

# primary key path
lawson_parent_key_dir=lawson_hierarchy/
lawson_parent_key_path=${tpm_workspace}${lawson_parent_key_dir}

# primary key
lawson_primary_key_dir=primary/
lawson_primary_key_path=${lawson_parent_key_path}

lawson_primary_key_name=lawson_primary
format=pem
lawson_primary_key_ctx=${lawson_primary_key_path}${lawson_primary_key_name}.ctx
lawson_primary_key_priv=${lawson_primary_key_path}${lawson_primary_key_name}.priv
lawson_primary_key_pub=${lawson_primary_key_path}${lawson_primary_key_name}.pub
cretificate=${lawson_primary_key_path}${lawson_primary_key_name}_public.${format}