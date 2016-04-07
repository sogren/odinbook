class CsrfProtection
  def incoming(message, request, callback)
    session_token = request.session['_csrf_token']
    message_token = message['ext'] && message['ext'].delete('csrfToken')
    user_id = request.session['warden.user.user.key'][0][0]

    unless true
      message['error'] = '401::Access denied'
    end
    Rails.logger.debug "siema"
    Rails.logger.debug session_token
    Rails.logger.debug message_token
    Rails.logger.debug message['error']
    Rails.logger.debug message
    Rails.logger.debug "reqruest"
    Rails.logger.debug message['channel']
    Rails.logger.debug "reqruest"
    Rails.logger.debug request
    Rails.logger.debug request.session
    Rails.logger.debug user_id
    Rails.logger.debug User.find(user_id)
    Rails.logger.debug request.session.options
    Rails.logger.debug request.session.values
    Rails.logger.debug callback
    Rails.logger.debug callback.call(message)
    Rails.logger.debug
    Rails.logger.debug User.all
    Rails.logger.debug "hehe thats all"
    callback.call(message)
  end
end
