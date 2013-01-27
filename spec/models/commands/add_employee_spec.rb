require 'spec_helper'
require 'commands/add_employee.rb'

describe AddEmployeeCommand do
  context "hourly rate" do
    before do
      args = ['jon', 'Tokyo', 'H', 1000]
      @add_emp_command = AddEmployeeCommand.new(args)
    end

    it "should add employee" do
      result = @add_emp_command.execute()
      result.should == 0
      added_emp = Employee::Employee.find_by_name("jon")
      added_emp.address.should == 'Tokyo'
      added_emp.salary_type.should == 0
      added_emp.salary_unit.should == 1000
    end
  end
end

describe AddEmployeeCommandParams do
  context "parse" do
    before do
      args = ['jon', 'Tokyo', 'H', 1000]
      @parser = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @parser.parse
      @parser.name.should == 'jon'
      @parser.address.should == 'Tokyo'
      @parser.salary_type.should == 0
      @parser.salary_unit.should == 1000
    end
  end
end
