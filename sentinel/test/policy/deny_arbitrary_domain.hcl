global "request" {
  value = {
    data = {
      common_name = "srv01.client.com"
    }
  }
}

test {
  rules = {
    has_common_name      = true
    common_name_is_valid = false
    main                 = false
  }
}
