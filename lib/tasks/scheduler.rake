# for production environment
namespace :waiting_list do
  desc "Send reconfirmation email to waiting list"

  task reconfirm: :environment do
    Request.send_reconfirmation
  end

  task clean: :environment do
    Request.clean
  end

end
