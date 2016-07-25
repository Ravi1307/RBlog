class AccountController < ApplicationController
  
  before_action :requiresLogIn, :only => [:logout, :edit, :update, :change_password, :update_password, :destroy];
  before_action :userLoggedIn, :except => [:logout, :edit, :update, :change_password, :update_password, :destroy];
  
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
      
      RblogMailer.user_registered(@user).deliver_now;
      
      redirect_to(:controller => 'account', :action => 'edit', :user => @user.username, :updateStatus => true) and return;
      
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
  
  def forgot_password
    
    @currentPage = 'forgot_password';
    
  end
  
  def forgot_password_request
    
    @currentPage = 'forgot_password';
    
    @user = Account.find_by(params.require(:account).permit(:email_address));
    
    if @user && @user.generatePasswordResetToken
      
      RblogMailer.user_password_reset(@user).deliver_now;
      
      @user.errors[:base] = 'Please follow the instructions sent to your mail.';
      
    else
      
      @user = Account.new(params.require(:account).permit(:email_address));
      @user.errors[:base] = 'There is no user with this email address in the system.';
      
    end
    
    render 'forgot_password';
    
  end
  
  def password_reset_expired
    
    @currentPage = 'password_reset_expired';
    
  end
  
  def password_reset
    
    @currentPage = 'password_reset';
    
    user = Account.find_by(password_reset_token: params[:token]);
    
    redirect_to(:controller => 'account', :action => 'password_reset_expired') and return unless user;
    
    @token = user.password_reset_token;
    
  end

  def password_reset_request
    
    @currentPage = 'password_reset';
    @user = Account.find_by(password_reset_token: params[:token]);
    
    redirect_to(:controller => 'account', :action => 'password_reset_expired') and return unless @user;
    
    @user.attributes = params.require(:account).permit(:password, :password_confirmation, :password_reset_token);
    
    if @user.save(:context => :changePassword)
      
      @user.errors[:base] = 'Your password has been changed. Please sign in.'
      
      redirect_to(:controller => 'account', :action => 'login') and return;
      
    else
      
      @token = params[:token];
      
      render 'password_reset';
      
    end
    
  end
  
  
  private
  
  def onLogOut
    
    session[:userStatus] = 'Log In';
    session[:userAction] = 'login';
    session[:userId] = nil;
    
  end
  
  def onLogIn(user)
    
    session[:userStatus] = 'Log Out';
    session[:userAction] = 'logout';
    session[:userId] = user.id;
    
  end
  
end
