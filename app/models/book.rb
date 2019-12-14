class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments
  has_many :favorites

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user) # 引数に渡したユーザーがレシーバーのbookにいいねしたかを判定するメソッド(ビューで使用する)
    favorites.where(user_id: user.id).exists?
  end
end
