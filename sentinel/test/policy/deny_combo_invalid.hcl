global "request" {
  value = {
    data = {
      common_name = "srv01.client.com"
      alt_names   = ["srv01", "srv01.client.com"]
    }
  }
}

test {
  rules = {
    // has_alt_names and alt_names_are_valid are never evaluated because
    // common_name_is_valid fails first
    has_common_name      = true
    common_name_is_valid = false
    main                 = false
  }
}
