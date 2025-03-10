set -x

source tcti.sh
if [ $1x = ''x ]; then
    tpm2_getcap ${tcti} -l
elif [ $1 = t ]; then
    tpm2_getcap ${tcti} handles-transient
elif [ $1 = p ]; then
    tpm2_getcap ${tcti} handles-persistent
elif [ $1 = pp ]; then
    tpm2_getcap ${tcti} handles-permanent
else
    tpm2_getcap ${tcti} $1
fi