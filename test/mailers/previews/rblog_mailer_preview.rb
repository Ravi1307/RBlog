# Preview all emails at http://localhost:3000/rails/mailers/rblog_mailer
class RblogMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/rblog_mailer/send_mail
  def send_mail
    RblogMailer.send_mail
  end

end
