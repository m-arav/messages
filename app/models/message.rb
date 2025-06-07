class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :to, type: String
  field :body, type: String
end
