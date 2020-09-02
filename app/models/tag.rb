class Tag < ApplicationRecord
  has_many :tags_blogs
  has_many :blogs, through: :tags_blogs

  before_save :strip_data_columns

  def strip_data_columns
    self.name = self.name.strip
  end

  def self.destroy_tags_blog(tags_blog)
    tags_blog.each do |element|
     Tag.find(element.tag_id).destroy if TagsBlog.where(tag_id: element.tag_id).size == 1
    end
  end
end
