crypto = require 'crypto'
bcrypt = require 'bcrypt'

module.exports =
  actions: require './actions'

  requireAuth: ->
    if not @session.get('userId') or @name is 'Main' or @name is 'Auth'
      @redirect '/login'

  cryptPass: (clearTextPass) ->
    throw new Error('Need application secret') if not geddy.config.secret

    return bcrypt.hashSync(clearTextPass, 10)
