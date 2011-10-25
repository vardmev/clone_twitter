class UserMailer < ActionMailer::Base
  default :from => "vardmev@gmail.com"
  
  def send_email(user, current_user)
    @user = user
    @current_user = current_user
    mail(:to => user.email,
         :subject => "You have +1 follower")
  end
end
