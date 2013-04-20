router = new geddy.RegExpRouter()
router.match('/').to controller: 'main', action: 'index'

router.post('/auth/local').to('Auth.local')
router.get('/auth/google').to('Auth.google')
router.get('/auth/google/callback').to('Auth.googleCallback')

router.resource 'main'
exports.router = router

