# Learn more: http://github.com/javan/whenever
set :environment, "development"

every 2.minutes do
  rake "waiting_list:reconfirm"
end
