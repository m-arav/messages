class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :to, type: String
  field :body, type: String
  field :sid, type: String
  field :status, type: String, default: "queued"
  belongs_to :user

  after_create :send_sms

  private

  def send_sms
    # TODO: Move to background Job
    TwilioClient.new.send(self).then do |resp|
      set(sid: resp.sid)
    end
  end
end
