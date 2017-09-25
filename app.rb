require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/division')
require('./lib/employee')
require('pg')
require('pry')

get('/') do
  @employees = Employee.all
  erb(:index)
end

post('/') do
  name = params['name']
  new_employee = Employee.create({:name => name})
  @employees = Employee.all
  erb(:index)
end

get('/employee/:id') do
  employee_id = params[:id]
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employee)
end

get('/employee/:id/edit') do
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employee_edit)
end

patch("/employee/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  @employees = Employee.all()
  erb(:index)
end
