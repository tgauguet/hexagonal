class ApplicationMailer < ActionMailer::Base
  default from: "removed_email_address@domain.invalid"
  layout 'mailer'
  require 'csv'

  def reconfirm_email(user)
    base_url = Rails.env.development? ? 'http://localhost:3000' : 'https://hexagonal-consulting.herokuapp.com'
    @btn_url = "#{base_url}/users/#{user.id}/reconfirm"
    @user = user
    @position = @user.booking.current_position

    mail(to: user.email, subject: 'Still want to join us ?')
  end

  def bookings_email(*args)
    @bookings = Booking.order('created_at ASC')
    email = args[0]
    format = args[1]
    
    begin
      xlsx_file = render_to_string formats: [:xlsx], template: "application_mailer/bookings_email", locals: { bookings: @bookings }

      xlsx_content = { mime_type: Mime[:xlsx], content: xlsx_file }
      csv_content = { mime_type: 'text/csv', content: @bookings.to_csv }
      attached_content = format == 'csv' ? csv_content : xlsx_content

      attachments["bookings_#{Date.today}.#{format}"] = attached_content
      mail(to: email, subject: "Your list format #{format}", body: "Your file in format #{format}")
    rescue => e
      puts "ERROR IN ApplicationMailer METHOD bookings_email :\n#{e}"
    end
  end

end
