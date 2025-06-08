class TwilioClient
  def initialize
    @client = Twilio::REST::Client.new(account_sid, token)
  end

  def send(message)
    @client.messages.create(
      messaging_service_sid: text_service_sid,
      to: to_number,
      body: message.body
    )
  end

  private

  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end

  def token
    Rails.application.credentials.twilio[:auth_token]
  end

  # Twilio virtual number
  def to_number
    Rails.application.credentials.twilio[:to_phone_number]
  end

  def text_service_sid
    Rails.application.credentials.twilio[:messaging_service_sid]
  end
end
