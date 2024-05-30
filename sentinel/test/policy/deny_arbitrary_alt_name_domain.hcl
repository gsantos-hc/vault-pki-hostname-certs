global "request" {
  value = {
    data = {
      alt_names = ["srv01", "srv01.client.com"]
    }
  }
}

test {
  rules = {
    has_common_name     = false
    has_alt_names       = true
    alt_names_are_valid = false
    main                = false
  }
}
