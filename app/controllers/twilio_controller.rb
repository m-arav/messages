class TwilioController < ApplicationController
  def webhook
    sid = params["MessageSid"]
    status = params["MessageStatus"]

    Message.find(sid: sid)
    message.update(status: status)
  rescue => e
    Rails.logger.error("[Twilio Webhook Error] #{e.class}: #{e.message}")
    head :ok
  end
end
