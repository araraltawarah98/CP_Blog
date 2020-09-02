class CreateTagsBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :tags_blogs do |t|
      t.references :blog
      t.references :tag

      t.timestamps
    end
  end
end
