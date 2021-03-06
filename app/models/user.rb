class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs
  has_many :comments, dependent: :destroy
  has_many :comments_blog, through: :comments, source: :blog

  validates_uniqueness_of :username

  extend FriendlyId
  friendly_id :username, use: :slugged

end
