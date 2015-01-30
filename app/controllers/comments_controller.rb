class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy
  def create   
    respond_to do |format|
      @entry = Entry.find_by(id: params[:comment][:entry_id])
      @comment = @entry.comments.build(comment_params)
      @comment.update_attribute(:user_id, params[:user_id])
      if @comment.save  
        format.html {
          redirect_to(root_url, notice: "Comment created")
        }
        #debugger
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
      else 
        format.html { render :action => 'users/show' }
        format.js
      end
    end
  end
  
  def destroy
    
    respond_to do |format|
      @comment.destroy
      format.html {
        redirect_to root_url
      }
      format.js {}
    end  
    #redirect_to request.referrer || root_url
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
