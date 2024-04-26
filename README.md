# Vault PKI – Hostname in DNS SAN Example

Sample Terraform configuration for standing up a PKI Secrets Engine in Vault
with a role that enables certificate issuance for a given list of hostnames.

The important parameter to set is `allow_bare_domains`, which enables
certificates to be issued for an _exact match_ to one of the `allowed_domains`.
So, if `allowed_domains` includes `host1`, a certificate can include `host1` in
its Common Name or as one of its DNS SANs.

Note: In this example, for simplicity, the Root CA is issuing end-entity
certificates directly. This is **not** a recommended pattern for a production
environment.

To verify that the issued certificate includes `host1` as one of its SANs (after
running `terraform apply`):

```
openssl x509 -in certificate.pem -noout -text
```
