class Blog < ApplicationRecord
  attr_accessor :tags_attributes

  has_many :tags_blogs, dependent: :destroy 
  has_many :tags, through: :tags_blogs
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  belongs_to :user

  before_save :strip_data_columns

  def strip_data_columns
    self.title = self.title.strip
    self.description = self.description.strip
  end
  
  def add_blog_tags
    self.tags_attributes.values.each do |element|
      tag = Tag.find_or_create_by(element)
      self.tags << tag
    end
  end

  def update_blog_tags
    self.tags_attributes.values.each do |element|
      tag = Tag.find(element[:id])
      tag.name = element[:name]
      tag.save
    end
  end  

  def get_blog_tags_attributes_uniq
    self.tags_attributes.values.uniq { |s| s[:name] }
  end

  def check_blog_tags_attributes_uniq
    get_blog_tags_attributes_uniq.size != 3 ? true : false
  end

  extend FriendlyId
  friendly_id :title, use: :slugged
end
