require "resque/server"
Resque::Server.use(Rack::Auth::Basic) do |user, password|
  Rails.logger.debug "testing for #{user} #{ResqueYetting.admin.inspect}"
  user == ResqueYetting.admin["user"] && password == ResqueYetting.admin["password"]
end

#Resque.redis           = ResqueYetting.redis[:url] 
Resque.redis.namespace = ResqueYetting.redis["namespace"]