class PostsController < ApplicationController
  
  before_action :requiresLogIn, :only => [:new, :create, :edit, :update, :destroy, :my_posts]; 
  
  layout 'rblog';
    
  def new
    
    @currentPage = 'new_post';
    
    render 'new_post';
    
  end
   
  def create
    
    @currentPage = 'new_post';
    
    user = Account.find(params[:blog_post][:account_id]);
    
    @post = user.posts.new(params.require(:blog_post).permit(:post_title, :post_message));
    
    if @post.save
      
      redirect_to(:controller => 'posts', :action => 'my_posts', :user => user.username) and return;
    
    else
      
      @currentPage = 'new_post';
      
      render 'new_post';
      
    end
    
  end

  def edit
    
    @currentPage = 'edit_post';
    
    user = Account.find(session[:userId]);
    
    @post = user.posts.find(params[:postId]);
    
    render 'new_post';
    
  end
  
  def update
    
    @currentPage = 'edit_post';
    
    user = Account.find(params[:blog_post][:account_id]);
    
    @post = user.posts.find(params[:postId]);
    
    if @post.update_attributes(params.require(:blog_post).permit(:post_title, :post_message))
      
      redirect_to(:controller => 'posts', :action => 'my_posts', :user => user.username) and return;
      
    else
      
      render 'new_post';
      
    end
    
  end
  
  def my_posts
    
    @currentPage = 'my_posts';
    
    @posts = Post.rBlogUserPosts(session[:userId]);
    
  end
  
  def destroy
    
    redirect_to(:controller => 'posts', :action => 'my_posts', :user => session[:username]) and return unless params[:postId].present?;
    
    @currentPage = 'delete_post';
    
    Post.find(params[:postId]).destroy;
    
    redirect_to(:controller => 'posts', :action => 'my_posts', :user => params[:user]);
    
  end
  
  def home
    
    @postsLimit = 5;
    @currentPage = 'home';
    @postsPage = params[:page].to_i;
    @rBlogUser = params[:user] || nil;
    @postsPageCount = (Post.rUserPostsCount(@rBlogUser).to_f / @postsLimit).ceil - 1;
    @posts = Post.rRecentPosts(@rBlogUser, @postsLimit, (@postsPage * @postsLimit));
    
  end

  def show
    
    redirect_to(:controller => 'posts', :action => 'home') and return unless params[:postId].present?;
    
    @currentPage = 'show';
    @post = Post.find(params[:postId]);
    
  end

  def site_map
    
    @currentPage = 'site_map';
    @users = Account.all;
    
  end
  
  def about
  
    @currentPage = 'about';
    
  end

  def contact

    @currentPage = 'contact';
    
  end
  
  def send_contact_form
    
    @currentPage = 'contact';
    
    RblogMailer.contact_form(params[:contact]).deliver_later;
    
    render 'contact';
    
  end
  
end
