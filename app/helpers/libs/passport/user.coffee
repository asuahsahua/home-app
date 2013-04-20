User = geddy.model.User
Passport = geddy.model.Passport

strategies = require './strategies'

_findOrCreateUser = (passport, profile, callback) ->
  passport.getUser (error, data) ->
    return callback(error) if error

    if not data
      userData = strategies[passport.authType].parseProfile profile
      user = User.create userData
      user.save { force: true }, (err, data) ->
        return callback(err) if err

        user.addPassport passport
        user.save { force: true }, (err, data) ->
          return callback(err) if err
          callback null, user


user = new ->
  @lookupByPassport = (authType, profile, callback) ->
    typeData = strategies[authType]
    key = String(profile[typeData.keyField])

    Passport.first { authType, key }, (err, data) ->
      return callback err if err

      if not data
        pass = Passport.create { authType, key }
        pass.save (err, data) ->
          return callback err if err
          _findOrCreateUser(pass, profile, callback)
      else
        _findOrCreateUser(data, profile, callback)


module.exports = user

