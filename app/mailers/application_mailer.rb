class ApplicationMailer < ActionMailer::Base
  default from: 'hexagoworking@gmail.com'
  layout 'mailer'

  def reconfirm_email(user)
    base_url = Rails.env.development? ? 'http://localhost:3000' : 'https://hexagonal-consulting.herokuapp.com'
    @btn_url = "#{base_url}/users/#{user.id}/reconfirm"
    @user = user
    @position = @user.booking.current_position

    mail(to: user.email, subject: 'Still want to join us ?')
  end
end
