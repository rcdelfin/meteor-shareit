Template.shareit_linkedin.onRendered ->
  return unless @data

  @autorun ->
    template = Template.instance()
    data = Template.currentData()

    preferred_url = data.url || ShareIt.location.origin() + ShareIt.location.pathname()
    url = encodeURIComponent preferred_url
    title = data.title
    description = encodeURIComponent data.linkedin?.description || data.description

    href = "https://www.linkedin.com/shareArticle?mini=true&url=#{url}&title=#{title}&summary=#{description}"

    template.$('.linkedin-share').attr 'href', href

Template.shareit_linkedin.events
  'click a': (event, template) ->
    event.preventDefault()
    window.open $(template.find('.linkedin-share')).attr('href'), 'linkedin_window', 'width=750, height=650'

Template.shareit_linkedin.helpers(ShareIt.helpers)
