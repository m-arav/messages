class TwilioClient
  def initialize
    @client = Twilio::REST::Client.new(account_sid, token)
  end

  def send(message)
    @client.messages.create(
      to: to_number,
      body: message.body,
      from: from_number
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

  # Twilio virtual number
  def from_number
    Rails.application.credentials.twilio[:from_phone_number]
  end
end
