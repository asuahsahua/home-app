# Handles the profileData -> User mapping

module.exports =
  google:
    name: 'Google'
    keyField: 'id'
    parseProfile: (profile) ->
      # TODO
      return {
        givenName: 'TestName'
      }

#  twitter:
#    name: 'Twitter'
#    keyField: 'id'
#    parseProfile: (profile) ->
#      userData = { }
#      if (profile.displayName)
#        names = profile.displayName.split /\s/
#        userData.givenName = names.shift()
#        userData.familyName = names.pop() if names.length
#      else
#        userData.givenName = profile.username
#      return userData
#
#  facebook:
#    name: 'Facebook'
#    keyField: 'id'
#    parseProfile: (profile) ->
#      return {
#        givenName: profile.name.givenName || profile.username
#        familyName: profile.name.familyName
#      }
