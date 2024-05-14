global "request" {
  value = {
    data = {
      common_name = "test.client.com"
      alt_names   = ["test", "test.client.com"]
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
