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

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content).or(Post.where(category: content))
    elsif method == 'forward'
      Post.where('title LIKE ?', "#{content}%").or(Post.where('category LIKE ?', "#{content}%"))
    elsif method == 'backward'
      Post.where('title LIKE ?', "%#{content}").or(Post.where('category LIKE ?', "%#{content}"))
    elsif method == 'partial'
      Post.where('title LIKE ?', "%#{content}%").or(Post.where('category LIKE ?', "%#{content}%"))
    else
      # Default to partial match if method is not recognized
      Post.where('title LIKE ?', "%#{content}%").or(Post.where('category LIKE ?', "%#{content}%"))
    end
  end
end
