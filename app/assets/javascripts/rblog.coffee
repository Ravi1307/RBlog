# @author Ravi

@togglePassword = (name) -> 
  password = $(['.', name].join(''))
  passwordImage = $(['#', name].join(''))
  if password.attr('type') is 'text'
    passwordImage.attr('src', '/assets/rblog_password_secure')
    password.attr('type', 'password')
  else
    passwordImage.attr('src', '/assets/rblog_password_not_secure')
    password.attr('type', 'text')
  password.focus()
  password.prop('selectionStart', password.val().length)
  return false

