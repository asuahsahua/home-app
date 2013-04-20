passport = require 'passport'
bcrypt = require 'bcrypt'
user = require './user'
_ = require 'underscore'

config = geddy.config.passport

successRedirect = config.successRedirect
failureRedirect = config.failureRedirect

cryptPass = null

SUPPORTED_SERVICES = _.keys(require './strategies')

SUPPORTED_SERVICES.forEach (service) ->
  hostname = geddy.config.fullHostname || ''

  config = {
    callbackUrl: "#{hostname}/auth/#{service}/callback"
    returnURL: "#{hostname}/auth/#{service}/callback"
  }

  Strategy = require("passport-#{service}").Strategy

  geddy.mixin config, geddy.config.passport[service]
  passport.use new Strategy config, (token, tokenSecret, profile, done) ->
    done null, profile

actions = new ->
  self = this
  _createInit = (authType) ->
    return (req, resp, params) ->
      throw new Error('no session') if not self.session
      req.session = self.session.data
      passport.authenticate(authType)(req, resp)

  _createCallback = (authType) ->
    return (req, resp, params) ->
      req.session = self.session.data
      passport.authenticate authType, (err, profile) ->
        return self.redirect failureRedirect if not profile

        try
          user.lookupByPassport authType, profile, (err, user) ->
            return self.error(err) if err

            self.session.set 'userId', user.id
            self.session.set 'authType', authType
            self.redirect successRedirect
        catch e
          self.error e

  self.local = (req, resp, params) ->
    username = params.username
    geddy.model.User.first { username }, { nocase: ['username'] }, (err, user) ->
      return self.redirect(failureRedirect) if err or not user

      cryptPass = require('./index').cryptPass if not cryptPass

      if bcrypt.compareSync params.password, user.password
        self.session.set 'userId', user.id
        self.session.set 'authType', 'local'
        self.redirect successRedirect

  SUPPORTED_SERVICES.forEach (service) ->
    self[service] = _createInit service
    self[service + 'Callback'] = _createCallback service

module.exports = actions
