Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user == ResqueYettings.admin.user && password == ResqueYettings.admin.password
end

Resque.redis           = ResqueYettings.redis.url 
Resque.redis.namespace = ResqueYettings.redis.namespace