global "request" {
  value = {
    data = {
      common_name = "srv01.approved.com"
    }
  }
}

test {
  rules = {
    has_common_name      = true
    common_name_is_valid = true
    main                 = true
  }
}
