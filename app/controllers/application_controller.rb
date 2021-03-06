class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  
  private
  
  def requiresLogIn
    
    unless session[:userId]
      
      redirect_to(:controller => 'account', :action => 'login');
      
    end
    
  end
  
  def userLoggedIn
    
    if session[:userId]
      
      redirect_to(:controller => 'posts', :action => 'my_posts', :user => Account.rBlogUsername(session[:userId]));
      
    end
    
  end
  
end
