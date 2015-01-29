class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy
  def create
    entry = Entry.find_by(id: params[:entry_id])
    @comment = entry.comments.build(comment_params)
    @comment.update_attribute(:user_id, params[:user_id])
    #debugger
    if @comment.save
      flash[:success] = "Comment created"
      redirect_to root_url
    else 
      flash[:danger] = "Comment not create"
      redirect_to root_url
    end  
  end
  
  def destroy
    @comment.destroy
    redirect_to request.referrer || root_url
  end  

  private 
      def comment_params
        params.require(:comment).permit(:content, :entry_id, :user_id)
      end

      def correct_user
        @comment = current_user.comments.find_by(id: params[:id])
        redirect_to root_url if @comment.nil?
      end  
end
