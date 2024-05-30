global "request" {
  value = {
    data = {
      common_name = "srv01.approved.com"
      alt_names   = ["srv01", "srv01.approved.com"]
    }
  }
}

test {
  rules = {
    has_common_name     = true
    has_alt_names       = true
    alt_names_are_valid = true
    main                = true
  }
}
