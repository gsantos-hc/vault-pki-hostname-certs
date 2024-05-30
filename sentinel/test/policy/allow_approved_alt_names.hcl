global "request" {
  value = {
    data = {
      alt_names = ["srv01", "srv01.approved.com"]
    }
  }
}

test {
  rules = {
    has_common_name     = false
    has_alt_names       = true
    alt_names_are_valid = true
    main                = true
  }
}
