dir=owner_lawsonzhang

if [ ! -d ${dir} ]; then
    mkdir owner_lawsonzhang
fi
cd owner_lawsonzhang

if [ ! -f primary.ctx ]; then
    tpm2_createprimary -C o -c primary.ctx --creation-data primary.creationdata --template-data primary.templatedata
else
    echo "Do you need to recreate the primary.ctx?"
    read -p "y/n" is_recreate
    if [ ${is_recreate} == "y" ]; then
        tpm2_createprimary -C o -c primary.ctx --creation-data primary.creationdata --template-data primary.templatedata -u unique/unique.hex
    else
        echo ${is_recreate}
        exit 0
    fi
fi