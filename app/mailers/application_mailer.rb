class ApplicationMailer < ActionMailer::Base
  
  default from: "'RBlog' <info@rblog.com>"
  
  layout 'mailer';
  
end
