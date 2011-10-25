ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "railscasts.com",
  :user_name            => "vardmev",
  :password             => "v83d20e03",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
