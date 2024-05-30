global "request" {
  value = {
    data = {
      csr = "test_csr_irrelevant"
    }
  }
}

test {
  rules = {
    has_common_name = false
    has_alt_names   = false
    main            = false
  }
}
