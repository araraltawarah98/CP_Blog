class CommentsController < ApplicationController
  def create
    puts params[:id]
    @comment = Comment.new(set_params_comments)
    @comment.user_id = current_user.id
    @comment.blog_id = params[:id]
    if @comment.save
      respond_to do |format|
        format.html { redirect_to blogs_path }
      end
    end
  end

  private

  def set_params_comments
    params.require(:comment).permit(:content)
  end
end
