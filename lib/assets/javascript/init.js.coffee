window.Initjs =
  initialize: ->
    infos = $("#init-js")
    controllerClass = infos.data("controller-class")
    controllerName = infos.data("controller-name")
    action = infos.data("action")
    this.execFilter('init')
    this.exec(controllerClass, controllerName, action)
    this.execFilter('finish')

  exec: (controllerClass, controllerName, action) ->
    namespace = App

    if controllerClass
      railsNamespace = controllerClass.split("::").slice(0, -1)
    else
      railsNamespace = []

    for name in railsNamespace
      namespace = namespace[name] if namespace

    if namespace and controllerName
      controller = namespace[controllerName]
      if controller and View = controller[action]
        App.currentView = window.view = new View()

  execFilter: (filterName) ->
    if App.Common and _.isFunction(App.Common[filterName])
      App.Common[filterName]()

jQuery ->
  window.Initjs.initialize()

  unless typeof(Turbolinks) == 'undefined'
    document.addEventListener "page:change", ->
      window.Initjs.initialize()

