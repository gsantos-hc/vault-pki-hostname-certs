global "request" {
  value = {
    data = {
      common_name = ""
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
