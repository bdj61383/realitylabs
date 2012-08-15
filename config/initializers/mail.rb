# This file was created per the instructions for SendGrid found here: https://devcenter.heroku.com/articles/sendgrid  I changed the username and password to those provided by SendGrid, but have so far not changed the domain name, as I believe I am still a subdomain of heroku.com.  Once we switch to a new domain, we may need to change this.

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app6586745@heroku.com',
  :password       => 'Your Password',
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp