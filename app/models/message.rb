class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :to, type: String
  field :body, type: String
  field :sid, type: String
  field :status, type: String, default: "queued"
  belongs_to :user

  after_create :send_sms

  validates :body, presence: true, length: { minimum: 1, maximum: 250 }
  validates :to, presence: true, format: { with: /\A\+?\d{10,15}\z/, message: "must be a valid phone number" }

  private

  def send_sms
    # TODO: Move to background Job
    TwilioClient.new.send(self).then do |resp|
      set(sid: resp.sid)
    end
  end
end
