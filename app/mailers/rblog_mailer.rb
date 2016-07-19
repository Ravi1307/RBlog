class RblogMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.rblog_mailer.send_mail.subject
  #
  
  def contact_form(user)
    
    @user = user;
    
    mail to: "ravik9023@gmail.com";
    
  end
  
  def user_registered(user)
    
    @user = user;
    
    mail to: @user.email_address;
    
  end
  
end
