namespace :waiting_list do
  desc "Send reconfirmation email to waiting list"

  task reconfirm: :environment do
    Request.init_waiting_list
  end
end
