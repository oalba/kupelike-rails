class MessageMailer < ApplicationMailer
  default from: "kupelikeproject@gmail.com"
  default to: "kupelikeproject@gmail.com"

  def new_message(message)
    @message = message

    mail subject: "Message from #{message.name}"
  end
end
