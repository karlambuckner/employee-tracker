ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require("sinatra/activerecord")
require("task")

RSpec.configure do |config|
  config.after(:each) do
    Employee.all().each() do |task|
      employee.destroy()
    end
  end
end
