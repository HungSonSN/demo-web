class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @comment = Comment.new
    end
    @users = User.all    
  end

  def help
  end

  def about
  end

  def contact
  end
    
end
