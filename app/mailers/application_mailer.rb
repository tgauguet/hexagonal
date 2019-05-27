class ApplicationMailer < ActionMailer::Base
  default from: 'hexagoworking@gmail.com'
  layout 'mailer'

  def reconfirm_email(user)
    base_url = Rails.env.development? ? 'http://localhost:3000/' : 'https://hexagonal-consulting.herokuapp.com/'
    @btn_url = base_url + 'users/' + user.id + '/confirm-waiting-list'
    puts @btn_url
    @user = user

    mail(to: email, subject: 'Are you still interested to join us ?')
  end
end
