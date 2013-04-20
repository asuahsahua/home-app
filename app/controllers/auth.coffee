passport = require '../helpers/libs/passport'

exports.Auth = ->
  geddy.mixin this, passport.actions
#
#class exports.Auth
#  construct: ->
#    geddy.mixin this, passport.actions
