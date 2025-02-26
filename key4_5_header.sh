# parent key (storage key) to be duplicated is key4
# child key (leaf key) duplicated with its parent is key5

key4_dir=key4/
key4_path=${primary_key_path}${key4_dir}
key4_name=key4
key4_priv=${key4_path}${key4_name}.priv
key4_pub=${key4_path}${key4_name}.pub
key4_ctx=${key4_path}${key4_name}.ctx
key4_key_ctx=${key4_ctx}

key5_dir=key5/
key5_path=${key4_path}${key5_dir}
key5_name=key5
key5_priv=${key5_path}${key5_name}.priv
key5_pub=${key5_path}${key5_name}.pub
key5_ctx=${key5_path}${key5_name}.ctx
key5_key_path=${key5_path}