App.boardroom = App.cable.subscriptions.create "BoardroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#chats').append("<div class='row live-chat-box no-gutters'>
                          <div class='offset-1 col-2 live'>
                            <span>live!</span>
                          </div>
                          <div class='col-9 live-content'>
                            <span>"+data["username"]+"</span>
                            <p>"+data["message"]+"</p>
                          </div>
                        </div>");
  speak: (message) ->
    @perform 'speak', message: message

jQuery(document).on 'keypress', '[data-behavior~=boardroom_speaker]', (event) ->
  if event.keyCode is 13 # return
    App.boardroom.speak [event.target.value, $('[data-user]').attr('data-user'), $('[data-boardroom]').attr('data-boardroom')]
    event.target.value = ''
    event.preventDefault()
