class CommentsController < ApplicationController
  
  before_action :requiresLogIn;
  
  def create
    
    post = Post.find(params[:comment][:post_id]);
    
    @comment = post.comments.create(params.require(:comment).permit(:account_id, :comment_message));
    
    respond_to do |format|
      
      format.html { redirect_to(:controller => 'posts', :action => 'show', :user => 'Ravik9023', :postId => 2) }
      format.js {  }
      
    end
    
  end
  
end
