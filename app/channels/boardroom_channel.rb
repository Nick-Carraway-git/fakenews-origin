class BoardroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "boardroom_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(message)
    chat = Chat.new(message: message['message'][0], user_id: message['message'][1].to_i, boardroom_id: message['message'][2].to_i)
    chat.save
    ActionCable.server.broadcast 'boardroom_channel', message: message['message'][0]
  end
end
