class ChatMessage < ApplicationRecord
  after_create_commit { ChatMessageBroadcastJob.perform_later self }
  validates :content, presence: true

  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
end
