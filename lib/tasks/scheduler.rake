# for production environment

task reconfirm: :environment do
  Request.send_reconfirmation
end

task clean: :environment do
  Request.clean
end
