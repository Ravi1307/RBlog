class AccountController < ApplicationController
  
  before_action :requiresLogIn, :except => [:new, :login, :attempt_login, :create];
  before_action :userLoggedIn, :only => [:login, :attempt_login, :new, :create];
  
  layout 'raccount';
  
  def new
    
    @currentPage = 'register';
    
    render 'register';
    
  end
  
  def create
    
    @currentPage = 'register';
    @user = Account.new(params.require(:account).permit(:username, :email_address, :password, :password_confirmation));
    
    if @user.save
      
      onLogIn(@user);
      
      redirect_to(:controller => 'account', :action => 'edit', :user => @user.username) and return;
      
    else
      
      onLogOut;
      
      render 'register';
      
    end
    
  end
  
  def login
    
    @currentPage = 'login';
    
  end
  
  def attempt_login

    @currentPage = 'login';
    
    if params[:account].present?
      
      @user = Account.find_by(params.require(:account).permit(:email_address));
      
    end
    
    if @user && @user.authenticate(params[:account][:password])
      
      onLogIn(@user);
      
      redirect_to(:controller => 'posts', :action => 'my_posts', :user => @user.username) and return;
      
    else
      
      @user = @user || Account.new(params.require(:account).permit(:email_address));
      @user.errors[:base] = "Invalid Credentials";
      
      onLogOut;
      
      render 'login';
      
    end
    
  end
  
  def logout

    @currentPage = 'logout';
    
    onLogOut;
    
    redirect_to(:controller => 'account', :action => 'login') and return;
    
  end
  
  def edit
    
    @currentPage = 'profile';
    @user = Account.find(session[:userId]);
    @updateStatus = (params[:updateStatus].present? && params[:updateStatus] == 'true');
    
    render 'profile';
    
  end

  def update

    @currentPage = 'profile';
    @user = Account.find(params[:userId]);
    
    if @user.update_attributes(params.require(:account).permit(:username, :email_address, :mobile_number, :first_name, :last_name))
      
      redirect_to(:controller => 'account', :action => 'edit', :user => @user.username) and return;
      
    else
      
      @updateStatus = true;
      
      render 'profile';
      
    end
    
  end

  def change_password
    
    @currentPage = 'change_password';
    
  end
  
  def update_password

    @currentPage = 'change_password';
    @user = Account.find(params[:userId]);
    
    if @user.authenticate(params[:account][:password_old])
      
      @user.attributes = params.require(:account).permit(:password, :password_confirmation);
      
      if @user.save(:context => :changePassword)
        
        redirect_to(:controller => 'account', :action => 'edit', :user => @user.username) and return;
        
      else
        
        render 'change_password';
        
      end
      
    else
      
      @user.errors[:base] = "Password old doesn't match";
      
      render 'change_password';
      
    end
    
  end

  def destroy
    
    @currentPage = 'delete_account';
    
    Account.find(params[:userId]).destroy;
    
    logout;
    
  end
  
  def onLogOut
    
    session[:userStatus] = 'Log In';
    session[:userAction] = 'login';
    session[:username] = nil;
    session[:userId] = nil;
    
  end
  
  def onLogIn(userTemp)
    
    session[:userStatus] = 'Log Out';
    session[:userAction] = 'logout';
    session[:username] = userTemp.username;
    session[:userId] = userTemp.id;
    
  end
  
end
