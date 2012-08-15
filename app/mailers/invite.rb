class Invite < ActionMailer::Base
  default :from => "welcome@realitylabs.herokuapp.com"
 
  def invite_email(email, league_name, league_code)
    @email = email
    @league_name = league_name
    @league_code = league_code
    @url  = "http://realitylabs.herokuapp.com/users/new"
    mail(:to => @email, :subject => "You've been invited to join a Survivor Fantasy League!")
  end
end
