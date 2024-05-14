terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.2.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.5"
    }
  }
}

locals {
  pki_mount = var.configure_mount ? vault_mount.pki[0].path : var.pki_mount_path
  dns_names = ["host1", "host1.network.local"]
}

# Hostname TLS Certificate -----------------------------------------------------
resource "local_file" "signed_certificate" {
  filename = "certificate.pem"
  content  = vault_pki_secret_backend_sign.hostname.certificate
}

resource "vault_pki_secret_backend_sign" "hostname" {
  backend     = local.pki_mount
  name        = vault_pki_secret_backend_role.hostname.name
  common_name = tls_cert_request.hostname.subject.0.common_name
  csr         = tls_cert_request.hostname.cert_request_pem
}

resource "tls_cert_request" "hostname" {
  private_key_pem = tls_private_key.hostname.private_key_pem
  dns_names       = local.dns_names
  subject {
    common_name = local.dns_names[1]
  }
}

resource "tls_private_key" "hostname" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# PKI Mount Configuration ------------------------------------------------------
resource "vault_pki_secret_backend_role" "hostname" {
  backend            = local.pki_mount
  name               = "bare-hostname"
  allowed_domains    = local.dns_names
  allow_bare_domains = true # NOTE: This is the key to having "host1"
  ttl                = "3600"
}

resource "vault_pki_secret_backend_root_cert" "this" {
  count       = var.configure_mount ? 1 : 0
  backend     = local.pki_mount
  type        = "internal"
  common_name = "ACME Root CA"
}

resource "vault_mount" "pki" {
  count = var.configure_mount ? 1 : 0
  type  = "pki"
  path  = var.pki_mount_path
}
