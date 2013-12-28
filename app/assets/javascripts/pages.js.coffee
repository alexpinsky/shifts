class Pages
  constructor: (options={})->
    @container = options.container

  init: ->
    @container.find("#open_wrapper .btn").popover
      html: true
      trigger: "hover"
    @container.find("#find_wrapper .btn").popover
      html: true
      trigger: "hover"

$ ->
  pages = new Pages({container: $("#flow_wrapper")})
  pages.init()