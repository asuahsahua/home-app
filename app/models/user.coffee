class User
  constructor: ->
    @defineProperties
      username: { type: 'string', required: true }
      password: { type: 'string', required: true }
      familyName: { type: 'string', required: true }
      givenName: { type: 'string', required: true }
      email: { type: 'string', required: true }

    @validatesLength 'username', { min: 3 }
    @validatesLength 'password', { min: 8 }
    @validatesConfirmed 'password', 'confirmPassword'

    @hasMany 'Passports'

geddy.model.register 'User', User

