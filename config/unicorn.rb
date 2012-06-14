worker_processes 1
working_directory "/home/projects/electurer/"

preload_app true

timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen "/home/projects/electurer/tmp/socket/thin.sock", backlog: 64

pid "/home/projects/electurer/tmp/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "/home/projects/electurer/log/unicorn.stderr.log"
stdout_path "/home/projects/electurer/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end