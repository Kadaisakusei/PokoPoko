class Public::PostCommentsController < ApplicationController

  def create
    illustration = Illustration.find(params[:illustration_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.illustration_id = illustration.id
    comment.save
    redirect_to request.referer
  end



  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to illustration_path(params[:book_id])
  end



  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def illustration_params
    params.require(:book).permit(:title, :body)
  end

  #def new
  #end

  #def show
  #end

  #def edit
  #end

  #def index
  #end
end
