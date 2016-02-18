# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.client = new Faye.Client('/faye')


client.addExtension {
  outgoing: (message, callback) ->
    message.ext = message.ext || {}
    message.ext.csrfToken = $('meta[name=csrf-token]').attr('content')
    callback(message)
}

try
 client.unsubscribe '/chats'
catch
 console?.log "Can't unsubscribe." # print a message only if console is defined

client.subscribe '/chats', (payload) ->
  message = payload.message
  id = payload.id
  chat_window = $("#chat-#{id} .chat-messages")

  if chat_window
    chat_window.append(message) if message
    chat_window.scrollTop(chat_window[0].scrollHeight)
    $('#chat_message_content').val('')

$(document).on "click", '#minimize_button', (e) ->
  $('.chat').css("bottom", '-387px')
  $('.chat #maximize_button').show()
  $('.chat div').hide()
  $(this).css("display", 'none')

$(document).on "click", '#maximize_button', (e) ->
  $('.chat').css("bottom", '')
  $('.chat #minimize_button').show()
  $('.chat div').show()
  $(this).hide()

$(document).on "click", '#close_button', (e) ->
  $('.chat').remove()
