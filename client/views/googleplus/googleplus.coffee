Template.share8_googleplus.onRendered ->
  return unless @data

  @autorun ->
    template = Template.instance()
    data = Template.currentData()
    $('meta[itemscope]').remove()

    #
    # Schema tags
    #
    description = data.googleplus?.description || data.excerpt || data.description || data.summary
    url = data.url || Share8.location.origin() + Share8.location.pathname()
    canonicalUrl = url + '?_escaped_fragment_'
    title = data.title
    itemtype = data.googleplus?.itemtype || 'Article'
    $('html').attr('itemscope', '').attr('itemtype', "http://schema.org/#{itemtype}")
    # $('<meta>', { itemprop: 'name', content: Share8.location.hostname() }).appendTo 'head'
    # $('<meta>', { itemscope: '', itemtype: "http://schema.org/#{itemtype}" }).appendTo 'head'
    $('<link>', { href: canonicalUrl, rel: 'canonical'}).appendTo 'head'
    # $('<meta>', { itemprop: 'headline', content: title }).appendTo 'head'
    # $('<meta>', { itemprop: 'description', content: description }).appendTo 'head'

    if data.thumbnail
      if typeof data.thumbnail == "function"
        img = data.thumbnail()
      else
        img = data.thumbnail
    if img
      if not /^http(s?):\/\/+/.test(img)
        img = Share8.location.origin() + img

    # $('<meta>', { itemprop: 'image', content: img }).appendTo 'head'
    #
    # Google share button
    #

    href = "https://plus.google.com/share?url=#{encodeURIComponent url}"
    template.$(".googleplus-share").attr "href", href

customHelpers =
  clientid: -> Share8.settings.sites.googleplus.clientid
  contenturl: -> Template.currentData().url || Share8.location.origin() + Share8.location.pathname()
  prefilltext: ->
    data = Template.currentData()
    data.googleplus?.description || data.excerpt || data.description || data.summary
Template.share8_googleplus.helpers(_.extend(Share8.helpers, customHelpers))
