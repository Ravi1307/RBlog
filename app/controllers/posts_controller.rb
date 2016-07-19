class PostsController < ApplicationController
  
  before_action :requiresLogIn, :only => [:new, :create, :edit, :update, :destroy, :my_posts]; 
  
  layout 'rblog';
    
  def new
    
    @currentPage = 'new_post';
    
    render 'new_post';
    
  end
   
  def create
    
    @currentPage = 'new_post';
    @rPost = Post.new(params.require(:blog_post).permit(:account_id, :post_title, :post_message));
    
    if @rPost.save
      
      redirect_to(:controller => 'posts', :action => 'my_posts', :user => session[:username]) and return;
    
    else
      
      @currentPage = 'new_post';
      
      render 'new_post';
      
    end
    
  end

  def edit
    
    @currentPage = 'edit_post';
    @rPost = Post.find(params[:postId]);
    
    render 'new_post';
    
  end
  
  def update
    
    @currentPage = 'edit_post';
    @rPost = Post.find(params[:postId]);
    
    if @rPost.update_attributes(params.require(:blog_post).permit(:post_title, :post_message))
      
      redirect_to(:controller => 'posts', :action => 'my_posts', :user => session[:username]) and return;
      
    else
      
      render 'new_post';
      
    end
    
  end
  
  def my_posts
    
    @currentPage = 'my_posts';
    @userPostsTitle = Post.rPostsTitle(session[:userId]);
    
  end
  
  def destroy
    
    redirect_to(:controller => 'posts', :action => 'my_posts', :user => session[:username]) and return unless params[:postId].present?;
    
    @currentPage = 'delete_post';
    
    Post.find(params[:postId]).destroy;
    
    redirect_to(:controller => 'posts', :action => 'my_posts', :user => params[:user]);
    
  end
  
  def home
    
    @rPostsLimit = 4;
    @currentPage = 'home';
    @rPostsPage = params[:page].to_i;
    @rBlogAuthor = params[:author] || nil;
    @rPostsPagesCount = (Post.rUserPostsCount(@rBlogAuthor) / @rPostsLimit);
    @rPosts = Post.rRecentPosts(@rBlogAuthor, @rPostsLimit, (@rPostsPage * @rPostsLimit));
    
  end

  def show
    
    redirect_to(:controller => 'posts', :action => 'home') and return unless params[:postId].present?;
    
    @currentPage = 'show';
    @rPost = Post.find(params[:postId]);
    
  end

  def site_map
    
    @currentPage = 'site_map';
    @rBlog = Post.rBlogSitemap;
    
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
