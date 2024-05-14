global "request" {
  value = {
    data = {
      common_name = "test.approved.com"
      alt_names   = ["test", "test.approved.com"]
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
