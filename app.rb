require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/division')
require('./lib/employee')
require('./lib/project')
require('pg')
require('pry')

get('/') do
  @divisions = Division.all
  @projects = Project.all
  erb(:index)
end

post('/') do
  division = params['division']
  new_division = Division.create({:division => division})
  @divisions = Division.all
  erb(:index)
end

get('/division/:id') do
  @division = Division.find(params["id"].to_i)
  @employees = @division.employees
  erb(:division)
end

post('/division/:id') do
  division_id = params[:id]
  name = params['name']
  @division = Division.find(params["id"].to_i)
  new_employee = Employee.create({:name => name, :division_id => division_id})
  @employees = @division.employees
  erb(:division)
end

get('/employee/:id') do
  employee_id = params[:id]
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employee)
end
#
get('/employee/:id/edit') do
  @employee = Employee.find(params.fetch("id").to_i())
  erb(:employee_edit)
end
#
patch("/employee/:id") do
  name = params.fetch("name")
  @employee = Employee.find(params.fetch("id").to_i())
  @employee.update({:name => name})
  @employees = Employee.all()
  redirect("/employee/#{@employee.id}")
end

post('/project') do
  name = params['name']
  new_project = Project.create({:name => name})
  @projects = Project.all
  redirect("/")
end
