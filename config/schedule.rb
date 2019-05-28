# Learn more: http://github.com/javan/whenever
set :environment, "development"

every 2.minutes do # should be 4 hours
  rake "waiting_list:reconfirm"
  rake "waiting_list:clean"
end
