class ListMailer < ActionMailer::Base
  default :from => "watet@gmail.com"

  def share_list_email(user, email, wish_title, id)
    @user = user
    @pro_id = id
    @url  = "http://192.168.1.28:3005"
    @list_url = "http://localhost:3000/profile"
    @wish_title = wish_title
    mail(:to => email, :subject => "Your friend wants to share his list with you")
  end

  def share_contact_email(message, name, subject,email)
    @url  = "http://192.168.1.28:3005"
    @subject = subject
    @message = message
    @email = email
    mail(:from => "watet@gmail.com" )
    mail(:to => "yogesh.waghmare@newtechfusion.com",:subject => subject)
  end
end
