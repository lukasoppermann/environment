CappuccinoView = require './cappuccino-view'
{CompositeDisposable} = require 'atom'

module.exports = Cappuccino =
  cappuccinoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cappuccinoView = new CappuccinoView(state.cappuccinoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cappuccinoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cappuccino:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cappuccinoView.destroy()

  serialize: ->
    cappuccinoViewState: @cappuccinoView.serialize()

  toggle: ->
    console.log 'Cappuccino was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
