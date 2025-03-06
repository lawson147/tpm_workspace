source tcti.sh

if [ $1x = 'x' ]; then
    echo 'parameter is required'
    exit 1
fi
tpm2_readpublic ${titi} -c $1