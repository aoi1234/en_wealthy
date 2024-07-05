class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :vie_counts, dependent: :destroy
  has_many :notifications, as: :notififiavle, dependent: :destroy
  
  validates :caption, uniqueness: true, length: { in: 1..250 }
  validates :category, uniqueness: true, length: { in: 1..250 }
end
