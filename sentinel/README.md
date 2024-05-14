# Vault EGP policy for controlling PKI subjects

Sample Vault
[Endpoint Governing Policy](https://developer.hashicorp.com/sentinel/docs/vault)
for enabling issuance of certificates containing both arbitrary host names and
corresponding FQDNs under a set of approved domain names.

## Configuration

### PKI Role

**IMPORTANT:** The PKI role **MUST** include the `use_csr_common_name = false`
and `use_csr_sans = false` attributes to block clients from working around the
Sentinel policy, which validates only the parameters in the API call itself
(i.e., not the CSR).

```shell
$ vault write pki/roles/any-hostname \
    allow_any_name="true" \
    allow_wildcard_certificates="false" \
    use_csr_common_name="false" \
    use_csr_sans="false"
```

### EGP Policy

**IMPORTANT:** Be sure to enforce this policy on any API endpoint where
protection is wanted.

```shell
$ vault write "sys/policies/egp/pki-limit-domains" \
    policy=@policy.sentinel \
    enforcement_level="hard-mandatory" \
    paths="pki/issue/any-hostname" \
    paths="pki/sign/any-hostname"
```
