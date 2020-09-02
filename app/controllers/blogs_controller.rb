class BlogsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @blogs = Blog.all
    @comment = Comment.new
  end

  def new
    @blog_item = Blog.new
    3.times { @blog_item.tags.build }
  end

  def create
    @blog_item = current_user.blogs.build(set_params_blogs)
    if @blog_item.check_blog_tags_attributes_uniq
      respond_to do |format|
        format.html { redirect_to new_blog_path, notice: 'No Duplicate tags' }
      end
    else
      @blog_item.add_blog_tags
      respond_to do |format|
        if @blog_item.save
          format.html { redirect_to blogs_path, notice: 'Blog was successfully created.' }
        else
          format.html { redirect_to new_blog_path }
        end
      end
    end
  end

  def show
    if Blog.friendly.exists?(params[:id])
      @blog_item = Blog.friendly.find(params[:id])
    else
      respond_to do |format|
        format.html { redirect_to blogs_path }
      end
    end
  end

  def edit
    @find_blog = current_user.blogs.friendly.exists?(params[:id])

    if @find_blog
      @blog_item = Blog.friendly.find(params[:id])
    else
      respond_to do |format|
        format.html { redirect_to blogs_path }
      end
    end
  end

  def update
    @blog_item = Blog.friendly.find(params[:id])
    @blog_item.update(set_tags_attribute)
    respond_to do |format|
      if @blog_item.check_blog_tags_attributes_uniq
        format.html { redirect_to edit_blog_path, notice: 'No Duplicate tags' }
      else
        @blog_item.update(update_params_blogs)
        @blog_item.slug = @blog_item.title
        @blog_item.save
        @blog_item.update_blog_tags
        format.html { redirect_to blogs_path, notice: 'Blog was successfully updated.' }
      end
    end 
  end

  def destroy 
    blog_item = Blog.friendly.find(params[:id])
    tags_blog = TagsBlog.where(blog_id: blog_item.id)
    Tag.destroy_tags_blog(tags_blog)
    blog_item.destroy
    respond_to do |format|
      format.html { redirect_to blogs_path }
    end
  end

  private #private_methods 

  def set_params_blogs
    params.require(:blog).permit(:title, :description, tags_attributes: [:name])
  end

  def update_params_blogs
    params.require(:blog).permit(:title, :description)
  end

  def set_tags_attribute
    params.require(:blog).permit(tags_attributes: [:name, :id])
  end
end
