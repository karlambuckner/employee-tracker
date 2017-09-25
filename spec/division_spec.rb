require "spec_helper"

describe(Division) do
  describe("#employee") do
    it("tells which tasks are in it") do
      test_division = Division.create({:division => "list"})
      test_division1 = Employee.create({:name => "Sarah", :division_id => test_division.id})
      test_division2 = Employee.create({:name => "Karah", :division_id => test_division.id})
     expect(test_division.employees()).to(eq([test_division1, test_division2]))
    end
  end
end
