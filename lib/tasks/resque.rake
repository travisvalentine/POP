require 'resque/tasks'
ENV["QUEUE"] = "*"
task "resque:setup" => :environment
task "jobs:work" => "resque:work"