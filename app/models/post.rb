class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, length: { in: 1..50 }
  validates :body, length: { in: 1..150 }
  validates :industry, length: { in: 1..50 }
  validates :category, length: { in: 1..50 }
end
