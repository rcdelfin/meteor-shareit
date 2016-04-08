Template.share8.helpers
  siteTemplates: ->
    ("share8_#{site}" for site in Share8.settings.siteOrder when Share8.settings.sites[site]?)
