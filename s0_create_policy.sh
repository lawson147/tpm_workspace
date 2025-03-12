tpm2_startauthsession -S session.dat
tpm2_policycommandcode -S session.dat -L policy.dat TPM2_CC_Duplicate
tpm2_flushcontext session.dat
tpm2_flushcontext