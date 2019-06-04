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
end

