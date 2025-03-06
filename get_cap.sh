if [ $1x = ''x ]; then
    tpm2_getcap ${tcti} -l
elif [ $1 = t ]; then
    tpm2_getcap ${tcti} handles-transient
else
    tpm2_getcap ${tcti} $1
fi