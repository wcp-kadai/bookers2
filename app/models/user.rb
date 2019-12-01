class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

  attachment :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, presence: true
  validates :introduction, length: { maximum: 50 }

  has_many :books
  has_many :book_comments
  has_many :favorites

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :from_messages, class_name: "ChatMessage", foreign_key: :from_id, dependent: :destroy
  has_many :to_messages, class_name: "ChatMessage", foreign_key: :to_id, dependent: :destroy

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end

