class Passport
  constructor: ->
    @defineProperties
      authType: { type: 'string' }
      key:      { type: 'string' }

    @belongsTo 'User'

geddy.model.register 'Passport', Passport
