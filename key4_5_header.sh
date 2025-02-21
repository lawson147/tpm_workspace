# parent key(storage key) is key3
# child key(leaf key) is key4

parent_key_dir=key4/
parent_key_path=${primary_key_path}${parent_key_dir}
parent_key_name=key4
parent_key_priv=${parent_key_path}${parent_key_name}.priv
parent_key_pub=${parent_key_path}${parent_key_name}.pub
parent_key_ctx=${parent_key_path}${parent_key_name}.ctx
key4_key_path=${parent_key_path}

child_key_dir=key5/
child_key_path=${parent_key_path}${child_key_dir}
child_key_name=key5
child_key_priv=${child_key_path}${child_key_name}.priv
child_key_pub=${child_key_path}${child_key_name}.pub
child_key_ctx=${child_key_path}${child_key_name}.ctx
key5_key_path=${child_key_path}