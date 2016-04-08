script_loader = (url, id, d = document) ->
  unless d.getElementById id
    fjs = d.getElementsByTagName('script')[0]
    js = d.createElement 'script'
    js.async = true
    js.defer = true
    js.id = id
    js.src = url
    fjs.parentNode.insertBefore js, fjs


Share8 =
  # plain location is wrong on spiderable.
  location:
    host: Meteor.bindEnvironment () ->
      Meteor.absoluteUrl().replace(/^http:\/\/|^https:\/\//, '').replace(/\/$/, '')
    href: Meteor.bindEnvironment () ->
      Meteor.absoluteUrl().replace(/\/$/, '') + location.pathname
    origin: Meteor.bindEnvironment () ->
      Meteor.absoluteUrl().replace(/\/$/, '')
    pathname: Meteor.bindEnvironment () ->
      location.pathname # "/showcontent/awjdaf2384" whatever the server location
    hostname: Meteor.bindEnvironment () ->
      Meteor.absoluteUrl().replace(/^http:\/\/|^https:\/\//, '').replace(/\/$/, '')
  settings:
    autoInit: true
    buttons: 'responsive'
    sites:
      facebook:
        'appId': null
        'version': 'v2.3'
        'description': ''
        'buttonText': 'Share on Facebook'
      twitter:
        'description': ''
        'buttonText': 'Share on Twitter'
      googleplus:
        'clientid': null
        'description': ''
        'buttonText': 'Share on Google+'
      pinterest:
        'description': ''
        'buttonText': 'Share on Pinterest'
      instagram:
        'description': ''
        'buttonText': 'Share on Instagram'
      linkedin:
        'description': ''
        'buttonText': 'Share on LinkedIn'
    siteOrder: []
    classes: 'large btn'
    iconOnly: false
    faSize: ''
    faClass: ''
    applyColors: true

  configure: (params) ->
    $.extend true, @settings, params if params?

  helpers:
    classes: -> Share8.settings.classes
    showText: (text) -> not Share8.settings.iconOnly and " #{text}"
    applyColors: (cssClasses) -> Share8.settings.applyColors and " #{cssClasses}"
    faSize: -> Share8.settings.faSize
    faClass: -> Share8.settings.faClass and " #{Share8.settings.faClass}"
    buttonText: ->
      facebook: Share8.settings.sites.facebook.buttonText
      twitter: Share8.settings.sites.twitter.buttonText
      googleplus: Share8.settings.sites.googleplus.buttonText
      pinterest: Share8.settings.sites.pinterest.buttonText
      instagram: Share8.settings.sites.instagram.buttonText
      linkedin: Share8.settings.sites.instagram.buttonText

  init: (params) ->
    @configure params if params?

    # Twitter
    script_loader '//platform.twitter.com/widgets.js', 'twitter-wjs'

    # Facebook
    if @settings.autoInit and @settings.sites.facebook?
      window.fbAsyncInit = =>
        FB.init @settings.sites.facebook

    $('<div id="fb-root"></div>').appendTo 'body' unless $('#fb-root').get(0)?
    script_loader '//connect.facebook.net/en_US/sdk.js', 'facebook-jssdk'

    # Google+
    window.___gcfg = {lang: 'en-US', parsetags: 'onload'}
    script_loader 'https://apis.google.com/js/platform.js', 'google-jssdk'
